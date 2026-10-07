CREATE TABLE "cinema" (
	"cinema_id" INTEGER NOT NULL UNIQUE,
	"name " VARCHAR(255) NOT NULL,
	"city" VARCHAR(255) NOT NULL,
	"address" VARCHAR(255) NOT NULL,
	"timezone" VARCHAR(255) NOT NULL,
	PRIMARY KEY("cinema_id")
);

CREATE TABLE "screens" (
	"screen_id" INTEGER NOT NULL UNIQUE,
	"screen_name" VARCHAR(255) NOT NULL,
	"total_seat" INTEGER NOT NULL,
	"screen_type" VARCHAR(255) NOT NULL,
	"cinema_id" INTEGER NOT NULL,
	PRIMARY KEY("screen_id")
);

CREATE TABLE "seat_master" (
	"seat_id" INTEGER NOT NULL UNIQUE,
	"screen_id" INTEGER NOT NULL,
	"row_label" VARCHAR(255) NOT NULL UNIQUE,
	"seat_type" VARCHAR(255) NOT NULL,
	"seat_number" INTEGER NOT NULL UNIQUE,
	PRIMARY KEY("seat_id")
);

CREATE TABLE "movies" (
	"movie_id" INTEGER NOT NULL UNIQUE,
	"title" VARCHAR(255) NOT NULL,
	"genre" VARCHAR(255) NOT NULL,
	"duration_minutes" INTEGER NOT NULL,
	"rating" DECIMAL NOT NULL,
	"release_date" DATE NOT NULL,
	PRIMARY KEY("movie_id")
);

CREATE TABLE "show_time" (
	"show_time_id" INTEGER NOT NULL UNIQUE,
	"movie_id" INTEGER NOT NULL,
	"screen_id" INTEGER NOT NULL,
	"start_time" TIMESTAMP NOT NULL,
	"end_time" TIMESTAMP NOT NULL,
	"base_price" DECIMAL NOT NULL,
	PRIMARY KEY("show_time_id")
);

CREATE TABLE "show_seats" (
	"show_seat_id" INTEGER NOT NULL UNIQUE,
	"seat_id" INTEGER NOT NULL UNIQUE,
	"show_time_id" INTEGER NOT NULL,
	"price" DECIMAL NOT NULL,
	"status" VARCHAR(255) NOT NULL,
	"held_by_user" VARCHAR(255) NOT NULL,
	"hold_expires_at" TIMESTAMP NOT NULL,
	PRIMARY KEY("show_seat_id")
);

CREATE TABLE "bookings" (
	"booking_id" INTEGER NOT NULL UNIQUE,
	"user_id" VARCHAR(255) NOT NULL,
	"show_time_id" INTEGER NOT NULL,
	"total_amount" DECIMAL NOT NULL,
	"booking_status" VARCHAR(255) NOT NULL,
	"booked_at" TIMESTAMP NOT NULL,
	PRIMARY KEY("booking_id")
);

CREATE TABLE "payments" (
	"payment_id" INTEGER NOT NULL UNIQUE,
	"booking_id" INTEGER NOT NULL,
	"payment_gateway" VARCHAR(255) NOT NULL,
	"payment_mode" VARCHAR(255) NOT NULL,
	"payment_status" VARCHAR(255) NOT NULL,
	"amount" DECIMAL NOT NULL,
	"payment_done_at" TIMESTAMP NOT NULL,
	PRIMARY KEY("payment_id")
);

ALTER TABLE "screens"
ADD FOREIGN KEY("cinema_id") REFERENCES "cinema"("cinema_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "seat_master"
ADD FOREIGN KEY("screen_id") REFERENCES "screens"("screen_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "show_time"
ADD FOREIGN KEY("movie_id") REFERENCES "movies"("movie_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "show_time"
ADD FOREIGN KEY("screen_id") REFERENCES "screens"("screen_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "show_seats"
ADD FOREIGN KEY("seat_id") REFERENCES "seat_master"("seat_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "show_seats"
ADD FOREIGN KEY("show_time_id") REFERENCES "show_time"("show_time_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "bookings"
ADD FOREIGN KEY("show_time_id") REFERENCES "show_time"("show_time_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "payments"
ADD FOREIGN KEY("booking_id") REFERENCES "bookings"("booking_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

-- Indexes on foreign key columns
CREATE INDEX "idx_screens_cinema_id" ON "screens"("cinema_id");
CREATE INDEX "idx_seat_master_screen_id" ON "seat_master"("screen_id");
CREATE INDEX "idx_show_time_movie_id" ON "show_time"("movie_id");
CREATE INDEX "idx_show_time_screen_id" ON "show_time"("screen_id");
CREATE INDEX "idx_show_seats_show_time_id" ON "show_seats"("show_time_id");
CREATE INDEX "idx_bookings_show_time_id" ON "bookings"("show_time_id");
CREATE INDEX "idx_payments_booking_id" ON "payments"("booking_id");