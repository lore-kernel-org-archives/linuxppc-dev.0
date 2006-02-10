Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E635167B73
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 10:27:09 +1100 (EST)
To: "dibacco\@inwind\.it" <dibacco@inwind.it>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: denx 2.4 kernel doesn't compile amd_flash.c 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 11 Feb 2006 00:00:49 +0100."
	<IUHULD$E8FF06F7D3BACC0D72A90B39E3254D5F@libero.it>
Date: Sat, 11 Feb 2006 00:27:08 +0100
Sender: wd@denx.de
Message-Id: <20060210232708.444F93525CC@atlas.denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <IUHULD$E8FF06F7D3BACC0D72A90B39E3254D5F@libero.it> you wrote:
> 
> I downloaded denx 2.4 kernel via cvs. I tried to compile it for a MBX board but I get the following problem:
> 
> amd_flash.c:143: error: structure has no member named `buswidth'

You probably misconfigured your kernel.

The standard sequence of

	-> make mbx_config ; make oldconfig && make dep && make -j8 uImage

works without problems here.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I will not say that women have no character;  rather, they have a new
one every day.                                               -- Heine
