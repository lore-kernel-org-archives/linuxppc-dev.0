Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D33BB67A66
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 07:30:44 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 25 Apr 2006 15:00:05 CDT."
	<1448E56E-1327-40D5-BE44-0DC103AC3E8A@kernel.crashing.org>
Date: Tue, 25 Apr 2006 23:30:43 +0200
Sender: wd@denx.de
Message-Id: <20060425213043.2860B352B18@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <1448E56E-1327-40D5-BE44-0DC103AC3E8A@kernel.crashing.org> you wrote:
>
> If we have a u-boot shim there are some questions that need answering:
> * where should the .dts live (hate duplicating the file both in u- 
> boot and kernel source tree)

Since U-Boot  does  not  need  nor  use  this  information  for  it's
operation, but the kernel does, it should be part of the kernel.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"We don't have to protect the environment -- the Second Coming is  at
hand."                                                   - James Watt
