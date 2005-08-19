Return-Path: <msm@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 0A759680DD
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Aug 2005 02:40:53 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	j7JGnVeg008363 for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 09:49:31 -0700 (MST)
Received: from az33exm43.am.freescale.net (az33exm43.am.freescale.net
	[10.64.34.249])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j7JGjva1024648
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 11:45:57 -0500 (CDT)
From: Matthew McClintock <msm@freescale.com>
To: SIP COP 009 <sipcop009@gmail.com>
In-Reply-To: <5a4792c005071910184f41c699@mail.gmail.com>
References: <5a4792c0050713235574522cfb@mail.gmail.com>
	<42DA0024.3050005@compulab.co.il>
	<5a4792c005071910184f41c699@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 19 Aug 2005 11:42:59 -0500
Message-Id: <1124469780.2587.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 8272ADS and Linux 2.6.12
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2005-07-19 at 10:18 -0700, SIP COP 009 wrote:
> Thanks all for the replies and help. I have the 2.6 Kernel running
> now. Here are few of the things that i did to make it happen:
> 
> 1: make ads8272_defconfig
> 2: edit .config to add the follow:
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_SERIAL_CPM=y
> CONFIG_SERIAL_CPM_CONSOLE=y
> CONFIG_SERIAL_CPM_SCC1=y
> CONFIG_SERIAL_CPM_SCC2=y

Are you sure it should not be SCC1 and SCC4? Can you verify SCC2 works
for you?

-Matthew
