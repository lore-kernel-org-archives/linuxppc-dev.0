Return-Path: <edfuchs@uni-kassel.de>
Received: from hrz-ws41.hrz.uni-kassel.de (smtp.hrz.uni-kassel.de
	[141.51.12.231]) by ozlabs.org (Postfix) with ESMTP id DFE3DDDE31
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 00:36:27 +1100 (EST)
Received: from ws-87.localnet (rs-pc1.rs.eecs.uni-kassel.de [141.51.112.154])
	by hrz-ws41.hrz.uni-kassel.de (8.14.0/8.14.0) with ESMTP id
	n31DaMt2015267
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Apr 2009 15:36:22 +0200
From: Eduard Fuchs <edfuchs@uni-kassel.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 8641D with linux 2.6.29 did'n show second cpu
Date: Wed, 1 Apr 2009 15:36:39 +0200
References: <200903311215.55237.edfuchs@uni-kassel.de>
	<200903311706.55478.edfuchs@uni-kassel.de>
	<E33D1DD7-FEA1-4B57-99C3-D2CA3BDE77E7@kernel.crashing.org>
In-Reply-To: <E33D1DD7-FEA1-4B57-99C3-D2CA3BDE77E7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904011536.39689.edfuchs@uni-kassel.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Am Mittwoch 01 April 2009 06:10:36 schrieb Kumar Gala:
> On Mar 31, 2009, at 10:06 AM, Eduard Fuchs wrote:
> > Hi,
> >
> > Am Dienstag 31 M=E4rz 2009 15:20:21 schrieb Kumar Gala:
> >> On Mar 31, 2009, at 5:15 AM, Eduard Fuchs wrote:
> >>> Hi,
> >>>
> >>> I'm testing the evaluation board from freescale (MPC8641DHPCN) with
> >>> the latest
> >>> linux kernel (2.6.29) and the second core seems disabled. CONFIG_SPM
> >>> is
> >>> enabled but the /proc/cpuinfo shows only one cpu. With original
> >>> 2.6.27 kernel
> >>> both cpu cores appears in /proc/cpuinfo.
> >>>
> >>> Has anyone an idea how can i enable the second core?
> >>
> >> Are you using u-boot?  I can't remember if you need a newer u-boot to
> >> deal with changes in how we bring up the second core.
> >
> > Yes. My u-boot version is 2009.03. Are there some additional config
> > keys for
> > SMP support in u-boot?
>
> It appears we introduced a bug in v2009.03 of u-boot.

I never thought that the problem could be in u-boot. I tested the board wit=
h=20
u-boot v2009.01 and it works well.

Best regard

Eduard Fuchs
