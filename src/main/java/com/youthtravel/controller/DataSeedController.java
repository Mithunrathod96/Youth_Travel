package com.youthtravel.controller;

import com.youthtravel.entity.Trip;
import com.youthtravel.entity.TripSchedule;
import com.youthtravel.entity.Vendor;
import com.youthtravel.repository.TripScheduleRepository;
import com.youthtravel.service.TripService;
import com.youthtravel.service.VendorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Optional;

@RestController
public class DataSeedController {

    @Autowired
    private VendorService vendorService;

    @Autowired
    private TripService tripService;

    @Autowired
    private TripScheduleRepository tripScheduleRepository;

    @GetMapping("/api/seed-data")
    public String seedData() {
        String email = "priyankapatil5379@gmail.com";
        Optional<Vendor> existingVendor = vendorService.findByEmailId(email);
        Vendor vendor;

        if (existingVendor.isPresent()) {
            vendor = existingVendor.get();
        } else {
            vendor = new Vendor();
            vendor.setBusinessName("Priyanka Adventures");
            vendor.setOwnerName("Priyanka Patil");
            vendor.setEmailId(email);
            vendor.setPhoneNumber("9876543211");
            vendor.setPassword("123");
            vendor.setCompanyAddress("Adventure Hub, Pune");
            vendor.setStatus("APPROVED");
            vendor.setTermsAccepted(true);
            vendor = vendorService.registerVendor(vendor);
        }

        // Count current trips
        long count = tripService.getTourCountByVendor(vendor);
        
        if (count < 15) { // Seed if less than our target
            createTrip(vendor, "Bali Tropical Paradise Getaway", "Explore the beautiful beaches and lush rice terraces of Bali.", "Uluwatu, Bali", 45000.0, "Couples", "International", 6, 5, "https://images.unsplash.com/photo-1537996194471-e657df975ab4");
            createTrip(vendor, "Swiss Alps Luxury Skiing", "Experience the ultimate skiing adventure in the heart of Switzerland.", "Zermatt, Switzerland", 125000.0, "Adventure", "International", 8, 7, "https://images.unsplash.com/photo-1502901664698-1110ca074bad");
            createTrip(vendor, "Spiti Valley Winter Expedition", "Witness the raw beauty of Spiti in its winter glory.", "Kaza, Spiti", 28000.0, "Youth", "Adventure", 9, 8, "https://images.unsplash.com/photo-1589308454676-47406a382c44");
            createTrip(vendor, "Varanasi Spiritual & Cultural Journey", "Experience the ancient traditions and morning ghat rituals.", "Varanasi, Uttar Pradesh", 7500.0, "Solo Travelers", "Cultural", 3, 2, "https://images.unsplash.com/photo-1561359313-0639aad49ca6");
            createTrip(vendor, "Goa Sun & Sand Party Week", "The ultimate beach party experience with luxury villa stays.", "Anjuna, Goa", 14000.0, "Youth", "Leisure", 5, 4, "https://images.unsplash.com/photo-1512100356956-c1227c348a03");
            createTrip(vendor, "Dubai Desert Luxury Safari", "Dune bashing, camel rides, and a night under the stars in Dubai.", "Dubai, UAE", 55000.0, "Families", "International", 4, 3, "https://images.unsplash.com/photo-1454496522488-7a8e5371842e");
            createTrip(vendor, "Coorg Coffee Plantation Escape", "Waken up to the aroma of fresh coffee in the Scotland of India.", "Madikeri, Coorg", 11000.0, "Couples", "Relaxing", 3, 2, "https://images.unsplash.com/photo-1580741569354-08fee8152016");
            createTrip(vendor, "Meghalaya Living Root Bridges Trek", "Discover the wonders of nature in the wettest place on Earth.", "Cherrapunji, Meghalaya", 16000.0, "Nature", "Adventure", 6, 5, "https://images.unsplash.com/photo-1500614922032-b6dd337b1313");
            createTrip(vendor, "Ooty Queen of Hills Retreat", "Enjoy the colonial charm and scenic toy train rides in Ooty.", "Ooty, Tamil Nadu", 9500.0, "Families", "Leisure", 4, 3, "https://images.unsplash.com/photo-1590490360182-c33d57733427");
            createTrip(vendor, "Pondicherry French Quarter Walk", "Explore the colorful streets and tranquil beaches of Pondicherry.", "White Town, Pondicherry", 8800.0, "Solo Travelers", "Cultural", 3, 2, "https://images.unsplash.com/photo-1582510003544-4d00b7f74220");
            
            // Add original ones if missing
            createTrip(vendor, "Himalayan Base Camp Trek", "Experience the ultimate adventure in the heart of Himalayas.", "Manali, Himachal", 15000.0, "Youth", "Adventure", 7, 6, "https://images.unsplash.com/photo-1464822759023-fed622ff2c3b");
            createTrip(vendor, "Kerala Luxury Houseboat Stay", "Relax with your family in the serene backwaters of Alleppey.", "Alleppey, Kerala", 25000.0, "Families", "Relaxing", 3, 2, "https://images.unsplash.com/photo-1593693397690-362cb9666fc2");
            createTrip(vendor, "Rajasthan Heritage Solo Backpacking", "Explore the royal forts and vibrant culture of Rajasthan.", "Jaipur, Rajasthan", 12000.0, "Solo Travelers", "Cultural", 5, 4, "https://images.unsplash.com/photo-1599661046289-e318978b6ffc");
            
            return "SUCCESS: 17 Trips Seeded for " + email + ". Refresh your dashboard!";
        }
        
        return "ALREADY SEEDED: " + email + " already has " + count + " trips.";
    }

    private void createTrip(Vendor vendor, String title, String desc, String dest, Double price, String cat, String subCat, Integer days, Integer nights, String img) {
        Trip trip = new Trip();
        trip.setVendor(vendor);
        trip.setTitle(title);
        trip.setDescription(desc);
        trip.setDestination(dest);
        trip.setPrice(price);
        trip.setTravelerCategory(cat);
        trip.setTravelerSubCategory(subCat);
        trip.setDays(days);
        trip.setNights(nights);
        trip.setImageUrl(img);
        trip.setStatus("Active");
        trip.setCreatedAt(java.time.LocalDateTime.now());
        
        Trip savedTrip = tripService.saveTrip(trip);

        TripSchedule schedule = new TripSchedule();
        schedule.setTrip(savedTrip);
        schedule.setStartDate(LocalDate.now().plusMonths(1));
        schedule.setStartTime(LocalTime.of(9, 0));
        schedule.setTotalSeats(20);
        schedule.setAvailableSeats(20);
        schedule.setStatus("Active");
        tripScheduleRepository.save(schedule);
    }
}
