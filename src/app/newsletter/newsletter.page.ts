import { Component } from '@angular/core';
import { IonicModule } from '@ionic/angular';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-newsletter',
  templateUrl: './newsletter.page.html',
  styleUrls: ['./newsletter.page.scss'],
  standalone: true,
  imports: [IonicModule, CommonModule, FormsModule]
})
export class NewsletterPage {
  formData = {
    firstName: '',
    mobilePhone: '',
    email: '',
    consent: false
  };

  constructor() {}

  submitForm() {
    if (!this.formData.consent) {
      alert('Please agree to receive marketing messages to subscribe.');
      return;
    }

    // Opens email client with pre-filled newsletter signup content
    const subject = encodeURIComponent('Newsletter Subscription Request');
    const body = encodeURIComponent(
      `Newsletter Signup Request\n\n` +
      `First Name: ${this.formData.firstName}\n` +
      `Mobile Phone: ${this.formData.mobilePhone}\n` +
      `Email: ${this.formData.email}\n\n` +
      `I consent to receive marketing and promotional messages.\n\n` +
      `Please send me the FREE playbook!`
    );
    window.location.href = `mailto:info@fourthgenformula.com?subject=${subject}&body=${body}`;
  }
}
