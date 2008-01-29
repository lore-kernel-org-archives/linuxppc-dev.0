Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1D5F7DDE38
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 06:50:11 +1100 (EST)
Message-ID: <479F836F.2080005@grandegger.com>
Date: Tue, 29 Jan 2008 20:50:07 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Mattias_Bostr=F6m?= <mattias.bostroem@gmail.com>
Subject: Re: Patches for Peak CAN driver for MPC5200B?
References: <10d674cb0801290848p8cd6d1xdf03e793e6de58a1@mail.gmail.com>
In-Reply-To: <10d674cb0801290848p8cd6d1xdf03e793e6de58a1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Hi Mattias,

Mattias Boström wrote:
> Hi,
> 
> We are using peak-linux-driver-3.17 with patches from DENX (mpc5200)
> and Freescale (mpc5200-platform_driver) on a MPC5200B. We have
> problems with rmmod, resulting in kernel panic. We also have a problem
> with not detecting BusOff. Does anyone know of additional patches that
> solve these problems?
> If we solve it ourselfs, would this be a good place to post patches?

This driver is not maintained any more. Are you aware of the Socket-CAN
project at BerliOS:

http://developer.berlios.de/projects/socketcan/
http://svn.berlios.de/wsvn/socketcan/trunk/README?op=file&rev=0&sc=0

It also supports the MSCAN driver and the CAN core will be merged into
2.6.25:

https://lists.berlios.de/pipermail/socketcan-core/2007-November/000795.html

Nevertheless, if you report me your problems, I might be able to help
you. And patches are always welcome.

Wolfgang.
