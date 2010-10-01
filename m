Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B8FFCB70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 22:10:01 +1000 (EST)
Subject: Re: [PATCH 01/18] powerpc: Add ability to build little endian kernels
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <AANLkTimGtB_KoOgwk3Ujn2UcNzs9qHxzeZcb1ShLgcXh@mail.gmail.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<1285916771-18033-2-git-send-email-imunsie@au1.ibm.com>
	<F7E7DAE6-A132-458D-ABC3-4CC92A4C7263@kernel.crashing.org>
	<AANLkTimGtB_KoOgwk3Ujn2UcNzs9qHxzeZcb1ShLgcXh@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Oct 2010 22:09:13 +1000
Message-ID: <1285934953.2463.72.camel@pasglop>
Mime-Version: 1.0
Cc: Michal Marek <mmarek@suse.cz>, linuxppc-dev@lists.ozlabs.org,
	Albert Herranz <albert_herranz@yahoo.es>,
	linux-kernel@vger.kernel.org, paulus@samba.org,
	Ian Munsie <imunsie@au1.ibm.com>, Andreas Schwab <schwab@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>,
	Torez Smith <lnxtorez@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-10-01 at 07:28 -0400, Josh Boyer wrote:
> > Shouldn't we have something that limits to the sub-arch'es that
> actually support it?  I doubt I'm ever going to make FSL-Book-e
> support LE.
> 
> Yes, it should. 

Sure, that's only WIP patches :-)

Tho FSL BookE would be relatively easy...

Cheers,
Ben.
