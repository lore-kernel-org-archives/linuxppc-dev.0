Return-Path: <edfuchs@uni-kassel.de>
Received: from hrz-ws41.hrz.uni-kassel.de (smtp.hrz.uni-kassel.de
	[141.51.12.231]) by ozlabs.org (Postfix) with ESMTP id 635C1DDDB6
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 02:06:47 +1100 (EST)
From: Eduard Fuchs <edfuchs@uni-kassel.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 8641D with linux 2.6.29 did'n show second cpu
Date: Tue, 31 Mar 2009 17:06:55 +0200
References: <200903311215.55237.edfuchs@uni-kassel.de>
	<446E5D82-7F37-42B5-8AD9-F8F368A5520A@kernel.crashing.org>
In-Reply-To: <446E5D82-7F37-42B5-8AD9-F8F368A5520A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903311706.55478.edfuchs@uni-kassel.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Am Dienstag 31 M=E4rz 2009 15:20:21 schrieb Kumar Gala:
> On Mar 31, 2009, at 5:15 AM, Eduard Fuchs wrote:
> > Hi,
> >
> > I'm testing the evaluation board from freescale (MPC8641DHPCN) with
> > the latest
> > linux kernel (2.6.29) and the second core seems disabled. CONFIG_SPM
> > is
> > enabled but the /proc/cpuinfo shows only one cpu. With original
> > 2.6.27 kernel
> > both cpu cores appears in /proc/cpuinfo.
> >
> > Has anyone an idea how can i enable the second core?
>
> Are you using u-boot?  I can't remember if you need a newer u-boot to
> deal with changes in how we bring up the second core.

Yes. My u-boot version is 2009.03. Are there some additional config keys fo=
r=20
SMP support in u-boot?

Best regard

Eduard
