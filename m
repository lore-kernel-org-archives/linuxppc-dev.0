Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 546DD679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 May 2006 19:53:41 +1000 (EST)
To: "IGOR LURI" <iluri@fagorautomation.es>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Linux doesn't boot if USB is enabled 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 12 May 2006 10:53:15 +0200."
	<918EB199DDDFFA42BEA2EB3A1C6021F3CE19E2@correo.fagorautomation.net>
Date: Fri, 12 May 2006 11:53:39 +0200
Sender: wd@denx.de
Message-Id: <20060512095339.421CC352B2A@atlas.denx.de>
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

In message <918EB199DDDFFA42BEA2EB3A1C6021F3CE19E2@correo.fagorautomation.net> you wrote:
> 
> We also have a mpc5200liteB evaluation board with u-boot 1.1.4 and linux
> 2.4.25 from Denx. We have realized that when USB is enabled linux
> doen´t boot, it hungs after u-boot uncompresses linux image.

You need the latest versions of both U-boot and Linux.

For U-Boot, you need a version after April 18 (see especially  commit
ID  8419c013048b1f15f3fa2fc7c0463d860a04ee3e).  For the Linux kernel,
you  need  a  version  after  April  21  (see  especially  commit  ID
1ac8b71bdbe6de928ba84c83831f6988a9b51165).

I recommend to grab the top-of-tree from both repositories.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Well, the way I see it, logic is only a way of being ignorant by num-
bers.                                 - Terry Pratchett, _Small Gods_
