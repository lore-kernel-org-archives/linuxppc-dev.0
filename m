Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0140.outbound.protection.outlook.com [207.46.100.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0D5B1A0C8F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 06:23:52 +1100 (AEDT)
Message-ID: <1419276217.5581.169.camel@freescale.com>
Subject: Re: [git pull] Please pull mpe/linux.git powerpc-3.19-2 tag
From: Scott Wood <scottwood@freescale.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Mon, 22 Dec 2014 13:23:37 -0600
In-Reply-To: <87r3vrbvpv.fsf@igel.home>
References: <1418980604.30631.1.camel@ellerman.id.au>
 <87r3vrbvpv.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-12-22 at 15:33 +0100, Andreas Schwab wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > Anton Blanchard (1):
> >       powerpc: Secondary CPUs must set cpu_callin_map after setting active and online
> 
> This breaks booting on the PowerMac7,3.  It takes forever to boot to
> user space (~5 minutes instead of ~4 seconds), and then I see these
> processes in top:
> 
>    37 root      20   0       0      0      0 D 0.000 0.000   0:00.00 kwindfarm
>    10 root      rt   0       0      0      0 R 0.000 0.000   0:00.00 migration/1
>    11 root      20   0       0      0      0 R 0.000 0.000   0:00.00 ksoftirqd/1
> 
> (The latter two processes don't accumulate any cpu time, but they are
> constantly in run state.)

http://patchwork.ozlabs.org/patch/423315/

-Scott
