Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 1A29DDDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Aug 2008 17:33:13 +1000 (EST)
Message-ID: <489802B3.805@coritel.it>
Date: Tue, 05 Aug 2008 09:35:15 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: "M. Warner Losh" <imp@bsdimp.com>
Subject: Re: Quick question about dts
References: <20080805.005649.1713918190.imp@bsdimp.com>
In-Reply-To: <20080805.005649.1713918190.imp@bsdimp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

M. Warner Losh ha scritto:
> I have a .dts file that works with 2.6.18 (MV Pro 5.0).  I encode it
> directly into the kernel image.  However, when I try to use it with my
> 2.6.23, 2.6.24 or 2.6.25 kernel trees, it doesn't work at all.  In the
> MV Pro 5.0 kernel, I hacked the startup sequence to store a pointer to
> this blob in r3 so that it is moved in.  I've done something similar
> in -current (for reasons that are too complicated to really explain
> well, we can't do this via the normal boot loader mechanisms).  The
> dtc complains that the interrupt-controller property is obsolete on
> the chosen device.
> 
> Does any documentation exist for how dts has evolved?  I'd like to
> forward port what I have without examining the .dts files from both
> versions and guessing...
> 
> Warner
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

Check out the kernel documentation booting-without-of.txt of your version.

Regards,

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
