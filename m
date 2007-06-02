Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id AECA7DDECC
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 18:23:29 +1000 (EST)
Message-ID: <466128F7.40306@semihalf.com>
Date: Sat, 02 Jun 2007 10:23:19 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: BestComm ATA task on MPC52xx
References: <4660A611.9020909@semihalf.com> <4661082C.70607@genesi-usa.com>
In-Reply-To: <4661082C.70607@genesi-usa.com>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey wrote:
> Which chip revision are you using?

Here's the configuration:

CPU:   MPC5200B v2.2, Core v1.4 at 350 MHz
       Bus 100 MHz, IPB 100 MHz, PCI 25 MHz

The board uses not quite typical 100 MHz bus clock, for which I don't
have a optimized ATA DMA timing parameters yet, instead, temporarily I
use too wasteful 132MHz settings.

Marian
