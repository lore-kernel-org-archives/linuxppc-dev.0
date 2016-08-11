Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [IPv6:2a03:3680:0:3::67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8phS7581zDqgN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 10:25:43 +1000 (AEST)
Date: Wed, 10 Aug 2016 17:25:33 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Gabriel Paubert <paubert@iram.es>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Fix crash during static key init on ppc32
In-Reply-To: <20160810085214.GA2117@visitor2.iram.es>
Message-ID: <alpine.DEB.2.20.14.1608101722590.8131@trent.utfs.org>
References: <alpine.DEB.2.20.14.1608082213450.8131@trent.utfs.org>
 <alpine.DEB.2.20.14.1608090157090.8131@trent.utfs.org>
 <1470743530.3015.38.camel@kernel.crashing.org>
 <87inv9te2n.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.14.1608092224220.8131@trent.utfs.org>
 <874m6tt8d0.fsf@concordia.ellerman.id.au>
 <1470814054.3015.98.camel@kernel.crashing.org>
 <alpine.DEB.2.20.14.1608100113430.8131@trent.utfs.org>
 <20160810085214.GA2117@visitor2.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 10 Aug 2016, Gabriel Paubert wrote:
> Just a question, does sleep work on your PowerBook? 

Oh, this PowerBook is on 24/7, it's a small home server and I don't think 
I ever used any sleep or hibernation modes on this machine. Sorry :\

C.
-- 
BOFH excuse #145:

Flat tire on station wagon with tapes.  ("Never underestimate the bandwidth of a station wagon full of tapes hurling down the highway" Andrew S. Tannenbaum)
