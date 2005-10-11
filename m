Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id 46CB96852F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 17:18:10 +1000 (EST)
To: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 11 Oct 2005 17:01:49 +1000."
	<434B635D.1000509@rftechnology.com.au>
Date: Tue, 11 Oct 2005 09:17:54 +0200
Sender: wd@denx.de
Message-Id: <20051011071754.8F73D353ADC@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: boot-time partitions and bootargs for 2.6.14 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <434B635D.1000509@rftechnology.com.au> you wrote:
>
> > mtdparts=physically_mapped_flash:1024k(Linux),4096k(FS),2048k(Unused),512k(U-Boot),512() 
> 
> Yep, I set
> mtdparts=phys_mapped_flash:1024k(Linux),4096k(FS),2048k(Unused),512k(U-Boot),512()

You may set it, but do you pass it as part of the boot arguments?

> Here is output:
> 
> Kernel command line: console=ttyCPM0,115200 root=31:01 rw rootfstype=jffs2
> PID hash table entries: 512 (order: 9, 8192 bytes)

No, you don't. [Do you understand now  why  complete  information  is
essential? If you had provided the boot log with the first posting we
would not have wasted our time looking for the wrong things.]

Make sure to add the mtdparts=... stuff to your bootargs!

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Even if you can deceive people about  a  product  through  misleading
statements, sooner or later the product will speak for itself.
- Hajime Karatsu
