Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 3970ADE0DC
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 16:58:48 +1000 (EST)
Date: Thu, 31 Jul 2008 16:58:47 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 5/8] Silence warning in arch/powerpc/mm/ppc_mmu_32.c
Message-ID: <20080731065847.GX20457@bakeyournoodle.com>
References: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
	<6827a84e83495f49c991a33b2cef07614273fa0a.1217476198.git.tony@bakeyournoodle.com>
	<20080731152125.2bfec5b7.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080731152125.2bfec5b7.sfr@canb.auug.org.au>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 03:21:25PM +1000, Stephen Rothwell wrote:
> Hi Tony,

Rusty has forever ruined 'Hi $name' ;P

<snip>
 
> Will this ever be built with CONFIG_PHYS_64BIT?

Updated patch follows.

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
