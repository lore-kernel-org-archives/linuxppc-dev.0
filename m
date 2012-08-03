Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 666962C0082
 for <linuxppc-dev@ozlabs.org>; Sat,  4 Aug 2012 08:34:20 +1000 (EST)
Message-ID: <1344033253.24037.70.camel@pasglop>
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Sat, 04 Aug 2012 08:34:13 +1000
In-Reply-To: <alpine.LFD.2.00.1208030838490.4148@right.am.freescale.net>
References: <alpine.LFD.2.00.1208030838490.4148@right.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-08-03 at 08:39 -0500, Kumar Gala wrote:
> Ben,
> 
> Weekly bug fix pull request.

Well, Linus is on holiday so I don't think it makes sense for me to ask
him to pull anything just yet... I'll put it in my tree some time next
week and will send it along with whatever I have as well when it looks
like he might be back :-)

Cheers,
Ben.

> - k
> 
> The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:
> 
>   Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge
> 
> for you to fetch changes up to c9f11c30374329a0d2a88cf05281ca49d8eca9ab:
> 
>   powerpc/fsl-pci: Only scan PCI bus if configured as a host (2012-08-03 08:25:52 -0500)
> 
> ----------------------------------------------------------------
> Jia Hongtao (1):
>       powerpc/fsl-pci: Only scan PCI bus if configured as a host
> 
>  arch/powerpc/sysdev/fsl_pci.c |   13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
