Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 7B303DE05D
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 11:40:29 +1000 (EST)
Date: Fri, 1 Aug 2008 11:40:26 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 5/8] Silence warning in arch/powerpc/mm/ppc_mmu_32.c
Message-ID: <20080801014026.GY20457@bakeyournoodle.com>
References: <20080731152125.2bfec5b7.sfr@canb.auug.org.au>
	<1c42eb99377e74cc128fa29aee8dc8b8@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1c42eb99377e74cc128fa29aee8dc8b8@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 01:54:13AM -0500, Milton Miller wrote:

> But please, cast the result of the shift.  Otherwise it will print 0MB 
> instead of 4096MB.

Done, patch (v3) on the way.  One day I'll get better at this "trivial"
stuff.

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
