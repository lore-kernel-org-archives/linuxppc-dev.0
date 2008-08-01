Return-Path: <reynekejunk@hotmail.com>
Received: from bay0-omc2-s5.bay0.hotmail.com (bay0-omc2-s5.bay0.hotmail.com
	[65.54.246.141]) by ozlabs.org (Postfix) with ESMTP id F3431DE0F6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Aug 2008 18:28:26 +1000 (EST)
Message-ID: <BAY101-W342207B5C88AD0881CDC96BE7F0@phx.gbl>
From: - Reyneke <reynekejunk@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Re: Lost time?
Date: Fri, 1 Aug 2008 08:28:24 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> Check the kernel's idea of what the timebase frequency is on both kernels=
.

> check for changes in the U-Boot and your u-Boot environment variables=2C =
device tree bolb content=2C etc=2C not just the kernel


Thanks for all the feedback. This going to hurt=2C but the problem was emba=
rrassingly simple. Our CONFIG_SYS_CLK_FREQ in u-boot was wrongly defined (w=
e did a u-boot upgrade as well - 1.3.3). Instead of 33000000 (doubled 16.5M=
hz input clock) it was defined as 33333333. And there is your 0.6sec for ev=
ery 60sec...

Using 20/20 hind site this is the first thing I SHOULD have checked=2C but =
there you go.

 Regards
   Jan Reyneke

_________________________________________________________________
The John Lewis Clearance - save up to 50% with FREE delivery
http://clk.atdmt.com/UKM/go/101719806/direct/01/=
