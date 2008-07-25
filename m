Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id BE1F5DE1CE
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 11:09:06 +1000 (EST)
Date: Thu, 24 Jul 2008 21:09:07 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix compile error with binutils 2.15
Message-ID: <20080724210907.407e9aa0@lappy.seanm.ca>
In-Reply-To: <25a77ae6580f7ea388ccae2f190b1b3f7415a928.1216944498.git.segher@kernel.crashing.org>
References: <25a77ae6580f7ea388ccae2f190b1b3f7415a928.1216944498.git.segher@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 25 Jul 2008 02:08:41 +0200
"Segher Boessenkool" <segher@kernel.crashing.org> wrote:

> My previous patch to fix compilation with binutils-2.17 causes
> a "file truncated" build error from ld with binutils 2.15 (and
> possibly older), and a warning with 2.16 and 2.17.
> 
> This fixes it.

And it does ;) Compiles with no warnings and boots.

Cheers,
   Sean
