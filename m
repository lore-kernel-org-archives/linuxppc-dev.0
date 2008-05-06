Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id CC268DDEEB
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 18:14:20 +1000 (EST)
From: Marvin <marvin24@gmx.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 5/5] PS3: Update ps3_defconfig
Date: Tue, 6 May 2008 10:14:15 +0200
References: <20080430215644.655638516@am.sony.com>
	<200805021545.01676.marvin24@gmx.de> <481F595F.2090407@am.sony.com>
In-Reply-To: <481F595F.2090407@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805061014.16229.marvin24@gmx.de>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Geoff,

On Monday 05 May 2008 21:00:47 you wrote:
> Marvin wrote:
> > what about adding these defaults:
> > 	- CONFIG_SCHED_SMT
> > 	- CONFIG_HUGETLBFS (needed by ibm cell sdk)

I'm using these for years now ;-)

> > not sure about:
> > 	- CONFIG_SPU_FS_64K_LS

I also have this option enabled. I think you can forget about it, as it seems 
to improve performance only in some corner cases. I'm not an expert, so maybe 
asking at cbe-oss-dev would be a better place. 

Thanks

Marvin

p.s. I installed fc9 last week and Xorg crashes when PCI is not enabled. just 
in case someone has the same problem.
