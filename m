Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 1C716DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Oct 2007 09:33:38 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so5937716wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 03 Oct 2007 16:33:38 -0700 (PDT)
Message-ID: <9e4733910710031633v3bb409c9j32b345e12396c1b0@mail.gmail.com>
Date: Wed, 3 Oct 2007 19:33:37 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Bruce_Leonard@selinc.com" <Bruce_Leonard@selinc.com>
Subject: Re: Device tree and external RTC
In-Reply-To: <OF5A3A8901.AAC62E29-ON88257369.007F3E0B-88257369.007FC5D0@selinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <OFFFD4BE8F.17F6E427-ON88257369.006D8651-88257369.00736D96@selinc.com>
	<OF5A3A8901.AAC62E29-ON88257369.007F3E0B-88257369.007FC5D0@selinc.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/3/07, Bruce_Leonard@selinc.com <Bruce_Leonard@selinc.com> wrote:
> I still think I've got a valid question about the device tree.  Isn't the
> purpose of the device tree to completely describe the HW to the kernel?
> Shouldn't I be able to add a child node to the i2c node describing the
> M41T00 RTC and have the kernel figure out that there's an RTC hanging off
> the I2C bus?  Or am I completely off base here?

I am having the same question about audio codecs. ALSA soc support is
designed to automatically load the right drivers depending on the
hardware in the device. Doesn't the device tree need to include the
codec chips? These chips are hooked up with various combinations of
i2s, ac97 and i2c.

-- 
Jon Smirl
jonsmirl@gmail.com
