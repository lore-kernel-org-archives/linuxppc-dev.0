Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id BD3DD67C4B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 06:38:59 +1000 (EST)
To: "Russell McGuire" <rmcguire@uwbt.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 13 Jul 2005 12:32:28 PDT."
	<20050713153231.GA17534@mail19d.g19.rapidsite.net>
Date: Wed, 13 Jul 2005 22:34:09 +0200
Sender: wd@denx.de
Message-Id: <20050713203409.B6B0C353A37@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: linux and sram 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20050713153231.GA17534@mail19d.g19.rapidsite.net> you wrote:
> 
> If we are using U-boot and populate the CFG_SRAM_SIZE and CFG_SRAM_BASE
> values, and makes sure this is passed into the kernel.
> 
> Does Linux 2.4.2x+ have any direct support for this? Is it just added into
> the regular memory pool? Does it get used for specific tasks?

The standard Linux kernel knows nothing about SRAM.

> Or is this set aside for custom drivers?

Indeed. You need a driver to support SRAM.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Microsoft Multimedia:
You have nice graphics, sound and animations when the system crashes.
