Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0DC93DDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 05:24:02 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JoO5t-0006r1-Rr
	for linuxppc-embedded@ozlabs.org; Tue, 22 Apr 2008 12:23:57 -0700
Message-ID: <16825460.post@talk.nabble.com>
Date: Tue, 22 Apr 2008 12:23:57 -0700 (PDT)
From: aaronsells <aaron.sells@zin-tech.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: SecretLab 2.6.24 with USB
In-Reply-To: <fa686aa40804211109g2f7f45d0gf836be46e2c1a40b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <800687fe0804141927y1f6ea75cv7ad0ba68b4fa637a@mail.gmail.com>
	<fa686aa40804211109g2f7f45d0gf836be46e2c1a40b@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Grant Likely-2 wrote:
> 
> Your best bet is to use
> Xilinx's git tree and manually patch in the c67x00 driver from Peter
> Korsgaard's driver.
> 
> http://www.mail-archive.com/linux-usb@vger.kernel.org/msg01907.html
> http://www.mail-archive.com/linux-usb@vger.kernel.org/msg01908.html
> http://www.mail-archive.com/linux-usb@vger.kernel.org/msg01906.html
> http://www.mail-archive.com/linux-usb@vger.kernel.org/msg01907.html
> 

I've tried this on my ML403 board with no success.  My Xilinx git tree is
current.  I'm using Peter's most recent patches from
http://peter.korsgaard.com/patches/linux/. I'm using an OpenEmbedded
console-image mounted via nfs as my root filesystem.  I don't receive any
messages when I plug USB devices into the board (keyboard, mouse, webcam). 
Any ideas on how I can troubleshoot this?
-- 
View this message in context: http://www.nabble.com/SecretLab-2.6.24-with-USB-tp16693847p16825460.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
