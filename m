Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1391C688F3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 Dec 2005 08:17:12 +1100 (EST)
To: "Kiran Kumar.A" <kiranf5@lycos.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 30 Dec 2005 06:21:11 EST."
	<20051230112111.58191CA092@ws7-4.us4.outblaze.com>
Date: Fri, 30 Dec 2005 22:17:10 +0100
Sender: wd@denx.de
Message-Id: <20051230211710.72899352597@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Regarding booting 440 gr board / ibm emac driver 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20051230112111.58191CA092@ws7-4.us4.outblaze.com> you wrote:
>
> This is kiran here. I'm working on 440GR (Yosemite) board to boot linux-2.6
> .13.4.

Don't use old code. Please use the current version.

> What could be the issue? Do we need to modify the driver for MAC address is
> sue??

Just use current code. You can find ready to  run  binaries  and  the
corresponding sources (git repository) on our server:

ftp://ftp.denx.de/pub/u-boot/images/amcc/yosemite/u-boot.bin
ftp://ftp.denx.de/pub/linux/images/amcc/yosemite/uImage
and http://www.denx.de/cgi-bin/gitweb.cgi?p=linux-2.6-denx.git
(git tag "DENX-2005-12-03-2208" or later).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A Puritan is someone who is deathly afraid that  someone,  somewhere,
is having fun.
