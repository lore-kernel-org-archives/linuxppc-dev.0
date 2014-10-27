Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B76751A00BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 08:17:06 +1100 (AEDT)
Message-ID: <1414444286.364.193.camel@pasglop>
Subject: Re: What is the reel purpose of in_beXX() and out_beXX() fonctions ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
Date: Tue, 28 Oct 2014 08:11:26 +1100
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1C9DFACE@AcuExch.aculab.com>
References: <544E3FF6.7090300@c-s.fr>
 <063D6719AE5E284EB5DD2968C1650D6D1C9DFACE@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-10-27 at 15:05 +0000, David Laight wrote:
> 
> Unfortunately the functions sometimes contain additional (often
> unneeded) 
> sequencing instructions - the driver may be able to perform multiple 
> operations between the sequencing instructions.

That's in part why some folks are working on proper relaxed accessors
(see Will Deacon's stuff)

Cheers,
Ben.
