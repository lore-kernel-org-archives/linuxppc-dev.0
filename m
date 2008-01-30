Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 530C5DDE48
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 11:56:07 +1100 (EST)
Date: Tue, 29 Jan 2008 18:56:07 -0600
From: Olof Johansson <olof@lixom.net>
To: maximilian attems <max@stro.at>
Subject: Re: ppc64 vecemu compile failure
Message-ID: <20080130005607.GA32622@lixom.net>
References: <20080130000337.GC25253@stro.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080130000337.GC25253@stro.at>
Cc: linuxppc-dev@ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>,
	Paul Mackerras <paulus@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Wed, Jan 30, 2008 at 01:03:37AM +0100, maximilian attems wrote:
> on latest git since driver subsys merge on powerpc64:
> 
> arch/powerpc/kernel/built-in.o: In function `fphalf':
> vecemu.c:(.toc+0x1360): undefined reference to `devices_subsys'
> make[3]: *** [.tmp_vmlinux1] Error 1

It's a known problem, fixed by:

http://patchwork.ozlabs.org/linuxppc/patch?id=16491

-Olof
