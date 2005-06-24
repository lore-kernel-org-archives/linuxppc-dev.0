Return-Path: <j.lu@tiesse.com>
Received: from tiesse.com (studiogesan.it [193.76.202.5])
	by ozlabs.org (Postfix) with ESMTP id 899C867B45
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Jun 2005 17:39:04 +1000 (EST)
Date: Fri, 24 Jun 2005 09:42:36 +0200
Message-Id: <200506240942.AA145163224@tiesse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Jianliang Lu" <j.lu@tiesse.com>
To: "Jordan, Kyle"  <kylej@aiinet.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: isp1362 usb driver 
Reply-To: j.lu@tiesse.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thank you Jordan.
The driver works quite good for control/bulk/interrupts, but we 
can't make it work with our eagle-usb driver for isochronous. We 
are still debugging it. If you have some informations about 
isochronous that may help us we'll be grateful for it.

Best regards,

Jianliang Lu

---------- Original Message ----------------------------------
From: "Jordan, Kyle" <kylej@aiinet.com>
Date: Wed, 22 Jun 2005 08:54:35 -0400

>> yes I would be really, really gratefully if you could send me 
the 
>> source.
>
>Ok, I've attached the source.  We have never tested isochronous
>endpoints though.  However I don't think I modified the section 
that
>controls isochronous data, so hopefully it still works.  I did 
change
>the names of the files, but they still go in drivers/usb/hcd or
>drivers/usb/host, depending on the version of the kernel.  I did 
have
>some statistics on some throughput tests I ran, but I can't seem 
to find
>those now.  If I come across them, I'll send them to you.  Let me 
know
>how this works.
>
>> The adsl modem we are using is a eagle chipset modem, based on 
>> eagle-usb project. The modem could be Sagem or aethra on ADI 
eagle 
>> chipset.
>
>Thanks, I think we are looking at the same chipset.  However we 
plan on
>using the ethernet option instead of the USB option because it 
will be
>slightly cheaper for us to do (at this time).
>
>
>- Kyle
>
>
                   
