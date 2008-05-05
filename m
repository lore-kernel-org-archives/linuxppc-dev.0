Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EE749DDE0C
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 05:00:53 +1000 (EST)
Message-ID: <481F595F.2090407@am.sony.com>
Date: Mon, 5 May 2008 12:00:47 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Marvin <marvin24@gmx.de>
Subject: Re: [patch 5/5] PS3: Update ps3_defconfig
References: <20080430215644.655638516@am.sony.com>
	<4818F1E0.4010609@am.sony.com> <200805021545.01676.marvin24@gmx.de>
In-Reply-To: <200805021545.01676.marvin24@gmx.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Marvin wrote:
> what about adding these defaults:
> 	- CONFIG_SCHED_SMT
> 	- CONFIG_HUGETLBFS (needed by ibm cell sdk)	
> 
> not sure about:
> 	- CONFIG_SPU_FS_64K_LS

Did you test these options?  Please let me know
your results.

-Geoff
