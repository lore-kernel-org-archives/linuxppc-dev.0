Return-Path: <lists@munckfish.net>
Subject: Re: [Cbe-oss-dev] Xorg crash when PCI not enabled (was [patch 5/5]
	PS3: Update ps3_defconfig)
From: Dan Munckton <lists@munckfish.net>
To: Marvin <marvin24@gmx.de>
In-Reply-To: <200805061014.16229.marvin24@gmx.de>
References: <20080430215644.655638516@am.sony.com>
	<200805021545.01676.marvin24@gmx.de> <481F595F.2090407@am.sony.com>
	<200805061014.16229.marvin24@gmx.de>
Content-Type: text/plain
Date: Tue, 06 May 2008 10:44:12 +0100
Message-Id: <1210067053.8444.14.camel@dylan>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

On Tue, 2008-05-06 at 10:14 +0200, Marvin wrote:
> p.s. I installed fc9 last week and Xorg crashes when PCI is not
> enabled. just 
> in case someone has the same problem.

The Ubuntu PS3 team is also working on an a couple of bugs relating to
lack of PCI info. I don't know if these are the same issues you're
facing. We're tracking them here at [0] and [2].

We had an initial crash was simple to fix [1]. Now we need to get X to
automatically load the fbdev driver instead of vesa [2].

Cheers

Dan

[0] https://bugs.launchpad.net/ubuntu-ps3-port/+bug/217647
[1] http://launchpadlibrarian.net/13569440/closedir.patch
[2] https://bugs.launchpad.net/ubuntu-ps3-port/+bug/219424
