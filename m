Return-Path: <rdunlap@xenotime.net>
Received: from xenotime.net (xenotime.net [66.160.160.81])
	by ozlabs.org (Postfix) with SMTP id 4DEB7DDFE3
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 03:32:02 +1000 (EST)
Received: from chimera.site ([72.90.125.186]) by xenotime.net for
	<linuxppc-dev@ozlabs.org>; Wed, 4 Jun 2008 10:31:59 -0700
Date: Wed, 4 Jun 2008 10:31:59 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/8 v4] mpc83xx_wdt rework, support for mpc8610 and mpc8xx
Message-Id: <20080604103159.80814067.rdunlap@xenotime.net>
In-Reply-To: <20080603211530.d6b3755a.akpm@linux-foundation.org>
References: <20080602173726.GA24556@polina.dev.rtsoft.ru>
	<20080603164830.32457962.akpm@linux-foundation.org>
	<20080604001739.GB24548@polina.dev.rtsoft.ru>
	<20080603173214.0bf71571.akpm@linux-foundation.org>
	<18502.5368.786188.835122@cargo.ozlabs.ibm.com>
	<20080603211530.d6b3755a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	wim@iguana.be, Paul Mackerras <paulus@samba.org>, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 3 Jun 2008 21:15:30 -0700 Andrew Morton wrote:

> On Wed, 4 Jun 2008 14:07:20 +1000 Paul Mackerras <paulus@samba.org> wrote:
> 
> > Looking at Linus' git tree, it's evident that some subsystems use the
> > the "[SUBSYSTEM]" notation and some use "subsystem:".  If there is now
> > an edict from on high that only "subsystem:" is acceptable, then I
> > must have missed that memo.
> 
> I'm all edicted out.  Sometimes one just puts forth the reasoning and
> lets others decide whether it's worth bothering about.  I could understand
> that decision being "no" :)

Well, it would be a Good Thing if all subsystem/arch maintainers would do it
in the same format, whatever that format is.

---
~Randy
<quote:>
"It's the Government of the United States." ... The largest, and yet
the least efficient, producer of computer software in the world.
