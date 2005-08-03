Return-Path: <ntl@pobox.com>
Received: from orb.pobox.com (orb.pobox.com [207.8.226.5])
	by ozlabs.org (Postfix) with ESMTP id 8B40A67E3F
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Aug 2005 12:29:39 +1000 (EST)
Date: Tue, 2 Aug 2005 21:17:42 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Jon Loeliger <jdl@freescale.com>
Message-ID: <20050803021742.GB3985@otto>
References: <1123023575.2614.25.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1123023575.2614.25.camel@cashmere.sps.mot.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: Beginning Merger Patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> Folks,
> 
> I have grabbed my asbestos suit.
> 
> Here is a patch to begin the process of merging
> the PPC32 and PPC64 include directories into a
> new common "powerpc" arch.

Perhaps you could briefly explain the motivation for this?

I think I've heard/read that something like this was in the works, but
I'd like to know what the problem is, and why it should be solved this
way instead of e.g. x86_64's method of including headers directly from
asm-i386.


Nathan
