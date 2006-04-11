Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 886DD679F3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 01:16:46 +1000 (EST)
Date: Tue, 11 Apr 2006 10:14:52 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Stefan Meyer <reyems@telkomsa.net>
Subject: Re: Linux kernel for MPC834X platform
In-Reply-To: <003101c65d7a$c68fbd60$1100a8c0@stefanlaptop>
Message-ID: <Pine.LNX.4.44.0604111013580.25404-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Tue, 11 Apr 2006, Stefan Meyer wrote:

> Hi Kumar
> Thanks for the advice. I will rebuild for powerpc and report back.
> B.t.w. what is the story behind the ppc and powerpc branches anyway ?

The powerpc tree is a merge of the ppc32/64 trees into one arch.  It 
requires a flat device tree to boot.  You will need a new u-boot for this 
that produces a flat device tree.

- kumar
