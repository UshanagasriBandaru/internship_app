import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';

class ShareService {
  static final ShareService _instance = ShareService._internal();
  factory ShareService() => _instance;
  ShareService._internal();

  // Share text content
  static Future<void> shareText({
    required String text,
    String? subject,
  }) async {
    try {
      await Share.share(
        text,
        subject: subject,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error sharing text: $e');
      }
    }
  }

  // Share job posting
  static Future<void> shareJob({
    required String jobTitle,
    required String companyName,
    required String jobId,
    String? description,
  }) async {
    try {
      final text = '''
🚀 New Job Opportunity at $companyName!

Position: $jobTitle

${description ?? 'Join our team and grow with us!'}

Apply now: https://lineyshathevan.com/app/job?id=$jobId

#LTSoftware #JobOpportunity #CareerGrowth
      '''.trim();

      await Share.share(text, subject: 'Job Opportunity: $jobTitle');
    } catch (e) {
      if (kDebugMode) {
        print('Error sharing job: $e');
      }
    }
  }

  // Share product
  static Future<void> shareProduct({
    required String productName,
    required String productId,
    String? description,
    String? price,
  }) async {
    try {
      final text = '''
🛠️ Check out this amazing product from LT Software!

Product: $productName
${price != null ? 'Price: $price' : ''}

${description ?? 'Innovative software solution for your business needs.'}

Learn more: https://lineyshathevan.com/app/product?id=$productId

#LTSoftware #Innovation #Technology
      '''.trim();

      await Share.share(text, subject: 'Product: $productName');
    } catch (e) {
      if (kDebugMode) {
        print('Error sharing product: $e');
      }
    }
  }

  // Share service
  static Future<void> shareService({
    required String serviceName,
    required String serviceId,
    String? description,
  }) async {
    try {
      final text = '''
💼 Professional Service from LT Software!

Service: $serviceName

${description ?? 'Expert software development and consulting services.'}

Learn more: https://lineyshathevan.com/app/service?id=$serviceId

#LTSoftware #ProfessionalServices #Consulting
      '''.trim();

      await Share.share(text, subject: 'Service: $serviceName');
    } catch (e) {
      if (kDebugMode) {
        print('Error sharing service: $e');
      }
    }
  }

  // Share company information
  static Future<void> shareCompany() async {
    try {
      const text = '''
🏢 Lineysha & Thevan Software Technologies

Pioneering Innovation in Technology

We deliver tailored software solutions for businesses of all sizes.

Services:
• Software Development
• System Integration
• Cybersecurity
• Cloud Solutions
• Data Analytics
• IT Consulting

Visit us: https://lineyshathevan.com
Contact: +91 8247252626

#LTSoftware #Innovation #Technology #SoftwareDevelopment
      ''';

      await Share.share(text, subject: 'LT Software Technologies');
    } catch (e) {
      if (kDebugMode) {
        print('Error sharing company: $e');
      }
    }
  }

  // Share app
  static Future<void> shareApp() async {
    try {
      const text = '''
📱 Download LT App - Your Gateway to Innovation!

Discover our services, products, and career opportunities.

Features:
• Company Information
• Product Catalog
• Service Offerings
• Job Board
• Direct Contact

Download now and stay connected with LT Software!

#LTApp #LTSoftware #Innovation
      ''';

      await Share.share(text, subject: 'LT App - Download Now');
    } catch (e) {
      if (kDebugMode) {
        print('Error sharing app: $e');
      }
    }
  }

  // Share on specific social media platforms
  static Future<void> shareOnWhatsApp({
    required String text,
    String? phoneNumber,
  }) async {
    try {
      final url = phoneNumber != null
          ? 'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(text)}'
          : 'whatsapp://send?text=${Uri.encodeComponent(text)}';
      
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sharing on WhatsApp: $e');
      }
    }
  }

  static Future<void> shareOnLinkedIn({
    required String text,
    String? url,
  }) async {
    try {
      final linkedInUrl = url != null
          ? 'https://www.linkedin.com/sharing/share-offsite/?url=${Uri.encodeComponent(url)}&title=${Uri.encodeComponent(text)}'
          : 'https://www.linkedin.com/sharing/share-offsite/?title=${Uri.encodeComponent(text)}';
      
      final uri = Uri.parse(linkedInUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sharing on LinkedIn: $e');
      }
    }
  }

  static Future<void> shareOnTwitter({
    required String text,
    String? url,
  }) async {
    try {
      final twitterUrl = url != null
          ? 'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(text)}&url=${Uri.encodeComponent(url)}'
          : 'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(text)}';
      
      final uri = Uri.parse(twitterUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sharing on Twitter: $e');
      }
    }
  }

  static Future<void> shareOnFacebook({
    required String text,
    String? url,
  }) async {
    try {
      final facebookUrl = url != null
          ? 'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(url)}&quote=${Uri.encodeComponent(text)}'
          : 'https://www.facebook.com/sharer/sharer.php?quote=${Uri.encodeComponent(text)}';
      
      final uri = Uri.parse(facebookUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sharing on Facebook: $e');
      }
    }
  }

  // Share via email
  static Future<void> shareViaEmail({
    required String subject,
    required String body,
    String? recipient,
  }) async {
    try {
      final emailUrl = recipient != null
          ? 'mailto:$recipient?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}'
          : 'mailto:?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';
      
      final uri = Uri.parse(emailUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error sharing via email: $e');
      }
    }
  }

  // Copy to clipboard
  static Future<void> copyToClipboard(String text) async {
    try {
      await Share.share(text);
    } catch (e) {
      if (kDebugMode) {
        print('Error copying to clipboard: $e');
      }
    }
  }
} 