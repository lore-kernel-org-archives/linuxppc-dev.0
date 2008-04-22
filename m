Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.240])
	by ozlabs.org (Postfix) with ESMTP id F345BDE026
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 06:10:02 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 31so3572727agc.0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Apr 2008 13:10:01 -0700 (PDT)
Message-ID: <fa686aa40804221309g7d0749e8qc329ad72389f0138@mail.gmail.com>
Date: Tue, 22 Apr 2008 14:09:59 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: aaronsells <aaron.sells@zin-tech.com>
Subject: Re: SecretLab 2.6.24 with USB
In-Reply-To: <16825460.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <800687fe0804141927y1f6ea75cv7ad0ba68b4fa637a@mail.gmail.com>
	<fa686aa40804211109g2f7f45d0gf836be46e2c1a40b@mail.gmail.com>
	<16825460.post@talk.nabble.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Apr 22, 2008 at 1:23 PM, aaronsells <aaron.sells@zin-tech.com> wrote:
>
>
>  Grant Likely-2 wrote:
>  >
>  > Your best bet is to use
>  > Xilinx's git tree and manually patch in the c67x00 driver from Peter
>  > Korsgaard's driver.
>  >
>  > http://www.mail-archive.com/linux-usb@vger.kernel.org/msg01907.html
>  > http://www.mail-archive.com/linux-usb@vger.kernel.org/msg01908.html
>  > http://www.mail-archive.com/linux-usb@vger.kernel.org/msg01906.html
>  > http://www.mail-archive.com/linux-usb@vger.kernel.org/msg01907.html
>  >
>
>  I've tried this on my ML403 board with no success.  My Xilinx git tree is
>  current.  I'm using Peter's most recent patches from
>  http://peter.korsgaard.com/patches/linux/. I'm using an OpenEmbedded
>  console-image mounted via nfs as my root filesystem.  I don't receive any
>  messages when I plug USB devices into the board (keyboard, mouse, webcam).
>  Any ideas on how I can troubleshoot this?

1. Post your boot log
2. Make sure a platform device for the usb controller is getting
registered with the kernel.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
