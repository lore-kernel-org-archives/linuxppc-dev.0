Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.237])
	by ozlabs.org (Postfix) with ESMTP id 2569ADE047
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Apr 2008 04:09:08 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so1409713wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Apr 2008 11:09:07 -0700 (PDT)
Message-ID: <fa686aa40804211109g2f7f45d0gf836be46e2c1a40b@mail.gmail.com>
Date: Mon, 21 Apr 2008 12:09:07 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sam Karp" <sam.d.karp@gmail.com>
Subject: Re: SecretLab 2.6.24 with USB
In-Reply-To: <800687fe0804141927y1f6ea75cv7ad0ba68b4fa637a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <800687fe0804141927y1f6ea75cv7ad0ba68b4fa637a@mail.gmail.com>
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

On Mon, Apr 14, 2008 at 8:27 PM, Sam Karp <sam.d.karp@gmail.com> wrote:
> Hi all,
>
> I've downloaded the SecretLab Xilinx Linux 2.6.24 Kernel and I'm trying to
> use a thumbdrive with the kernel.  I'm booting from a ramdisk and insert the
> thumbdrive but I have no /dev/sd* or /dev/hd* blocks.  Is there anything I
> need to add to the kernel or design to ensure that the thumbdrive is working
> or getting power?

Sorry I didn't get back to you earlier.  Your best bet is to use
Xilinx's git tree and manually patch in the c67x00 driver from Peter
Korsgaard's driver.

http://www.mail-archive.com/linux-usb@vger.kernel.org/msg01907.html
http://www.mail-archive.com/linux-usb@vger.kernel.org/msg01908.html
http://www.mail-archive.com/linux-usb@vger.kernel.org/msg01906.html
http://www.mail-archive.com/linux-usb@vger.kernel.org/msg01907.html

I haven't been keeping my tree up to date lately.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
