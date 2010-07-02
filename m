Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9248F1007D4
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jul 2010 15:47:32 +1000 (EST)
Subject: Re: CONFIG_NO_HZ causing poor console responsiveness
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <AANLkTilMzfwgYvoFhxhcVQVGV-EkMLVHI2TeQ29SYFCH@mail.gmail.com>
References: <AANLkTilMzfwgYvoFhxhcVQVGV-EkMLVHI2TeQ29SYFCH@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 02 Jul 2010 15:47:24 +1000
Message-ID: <1278049644.4200.377.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-06-29 at 14:54 -0500, Timur Tabi wrote:
> I'm adding support for a new e500-based board (the P1022DS), and in
> the process I've discovered that enabling CONFIG_NO_HZ (Tickless
> System / Dynamic Ticks) causes significant responsiveness problems on
> the serial console.  When I type on the console, I see delays of up to
> a half-second for almost every character.  It acts as if there's a
> background process eating all the CPU.
> 
> I don't have time to debug this thoroughly at the moment.  The problem
> occurs in the latest kernel, but it appears not to occur in 2.6.32.
> 
> Has anyone else seen anything like this?

I noticed that on the bimini with 2.6.35-rc* though I didn't get to
track it down yet.

Cheers,
Ben.
