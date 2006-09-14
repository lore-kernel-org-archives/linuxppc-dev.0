Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 30BBC67B7B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 10:52:18 +1000 (EST)
To: shyi@bmrtech.com
From: Wolfgang Denk <wd@denx.de>
Subject: Re: 11-16-05 2.6.14 on AMCC Yosemite boar d(PCI-IDE card boot error) 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 14 Sep 2006 04:11:25 +0800."
	<450865ED.4080000@bmrtech.com>
Date: Thu, 14 Sep 2006 02:52:16 +0200
Sender: wd@denx.de
Message-Id: <20060914005216.72C23353C57@atlas.denx.de>
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

In message <450865ED.4080000@bmrtech.com> you wrote:
>
> I have tested and debuged the ELDK's kernel 2.6.14 with PDC20269 PCI-IDE
> card, the system paniced when it run the 'ide_pci_setup_ports' funcation
> [drivers/ide/setup_pci.c], the attached files included the entry log
> messages, and ksysoops messages when the kernel paniced, and my kernel
> configuration file and BDI2000 configuration file.

First, you should be using recent code. YOu should use at least the
code tagged as DENX-2006-05-11-0050 (aka a733b0d0915a) from our git
repository.

But note that this will problably not result in a working IDE driver.
Many PCI IDE cards (drivers) have similar issues  when  used  in  big
endian (PowerPC) systems.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Don't think; let the machine do it for you!"        - E. C. Berkeley
