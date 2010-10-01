Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7326AB70FD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 22:22:48 +1000 (EST)
Subject: Re: [PATCH 01/18] powerpc: Add ability to build little endian kernels
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <AANLkTimdV2FTEhcKXcM_+k23PBFTR5KvyjqEGxzzX72Q@mail.gmail.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<1285916771-18033-2-git-send-email-imunsie@au1.ibm.com>
	<AANLkTimdV2FTEhcKXcM_+k23PBFTR5KvyjqEGxzzX72Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Oct 2010 22:22:22 +1000
Message-ID: <1285935742.2463.85.camel@pasglop>
Mime-Version: 1.0
Cc: Michal Marek <mmarek@suse.cz>, Sam Ravnborg <sam@ravnborg.org>,
	Albert Herranz <albert_herranz@yahoo.es>,
	linux-kernel@vger.kernel.org, paulus@samba.org,
	Ian Munsie <imunsie@au1.ibm.com>, Andreas Schwab <schwab@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	Torez Smith <lnxtorez@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-10-01 at 07:40 -0400, Josh Boyer wrote:
> Have you tested this support with a userspace containing floating
> point instructions?  I wonder if CONFIG_MATH_EMULATION is going to
> need work at all, and if the boards with an actual FPU (440EP, 440EPx,
> 460EX, etc) would have issues. 

That's one of the things on the TODO list. We've tested that on a 44x
with no FPU so far and made sure we built without math emu.

Cheers,
Ben.
