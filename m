Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A188067BAB
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 17:43:38 +1100 (EST)
Date: Fri, 15 Dec 2006 00:42:48 -0600
From: Olof Johansson <olof@lixom.net>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 6/9] MPIC MSI allocator
Message-ID: <20061215004248.3dd7f17b@pb15>
In-Reply-To: <C4505CE5-B961-43F1-803B-C20F43CAF408@kernel.crashing.org>
References: <1166006370.90082.476088563252.qpush@cradle>
	<20061213104007.4B8F967DA9@ozlabs.org>
	<20061213122353.7498a25e@pb15>
	<1166052344.11914.233.camel@localhost.localdomain>
	<20061213180921.487b1cea@pb15>
	<1166056373.11914.246.camel@localhost.localdomain>
	<1166057940.6838.25.camel@concordia.ozlabs.ibm.com>
	<1166058148.11914.255.camel@localhost.localdomain>
	<1166058412.6838.30.camel@concordia.ozlabs.ibm.com>
	<C53BBACC-211E-4B01-9153-75634372B835@kernel.crashing.org>
	<1166125466.31351.14.camel@localhost.localdomain>
	<DBBE020D-0BFA-44EC-B1C9-D33F96CC924D@kernel.crashing.org>
	<1166149729.31351.43.camel@localhost.localdomain>
	<C4505CE5-B961-43F1-803B-C20F43CAF408@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 15 Dec 2006 03:58:57 +0100 Segher Boessenkool <segher@kernel.crashing.org> wrote:

> "msi-ranges", if present, denotes the ranges of input
> interrupt numbers that can be used for MSIs (does this
> fit what you need well, Olof?)

Yep, sounds good to me!


-Olof
