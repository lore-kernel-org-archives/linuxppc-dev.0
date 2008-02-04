Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC575DDEC7
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 09:39:14 +1100 (EST)
Date: Tue, 5 Feb 2008 01:38:57 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/1] [PPC] 8xx swap bug-fix
Message-ID: <20080205013857.47ebe544@kernel.crashing.org>
In-Reply-To: <20080204182421.GA3930@loki.buserror.net>
References: <20080201181003.a3daf6ed.kim.phillips@freescale.com>
	<200802021047.32055.yur@emcraft.com> <47A45269.7080403@scram.de>
	<20080204182421.GA3930@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul, Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 4 Feb 2008 12:24:21 -0600
Scott Wood wrote:

> On Sat, Feb 02, 2008 at 12:22:17PM +0100, Jochen Friedrich wrote:
> > Hi Yuri,
> > 
> > >  Here is the patch which makes Linux-2.6 swap routines operate
> > > correctly on the ppc-8xx-based machines.
> > 
> > is there any 8xx board left which isn't ported to ARCH=powerpc?
> 
> More importantly, is this something that is also broken in
> arch/powerpc?  It looks like it has the same code...
> 
yes, it is. Though there is currently no best-at-all solution, this looks worth trying.
I'll have a look how the 8xx feels under load and report back.

-- 
Sincerely, Vitaly
