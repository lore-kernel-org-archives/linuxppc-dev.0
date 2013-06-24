Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 945262C0082
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 08:07:58 +1000 (EST)
Message-ID: <1372111669.3944.165.camel@pasglop>
Subject: Re: Pull request: scottwood/linux.git for-3.10
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 25 Jun 2013 08:07:49 +1000
In-Reply-To: <20130624220237.GA24585@home.buserror.net>
References: <20130624220237.GA24585@home.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-06-24 at 17:02 -0500, Scott Wood wrote:
> This fixes a regression that causes 83xx to oops on boot if a
> non-express PCI bus is present.  It is the same patch as the last pull
> request, but with the changelog reworded to be clearer that this is a
> regression.

Ok, Kumar, I'll pick that up and send to Linus.

Cheers,
Ben.

> The following changes since commit 17858ca65eef148d335ffd4cfc09228a1c1cbfb5:
> 
>   Merge tag 'please-pull-fixia64' of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux (2013-06-18 06:29:19 -1000)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git for-3.10
> 
> for you to fetch changes up to b37e161388ac3980d5dfb73050e85874b84253eb:
> 
>   powerpc/pci: Fix boot panic on mpc83xx (regression) (2013-06-24 16:54:09 -0500)
> 
> ----------------------------------------------------------------
> Rojhalat Ibrahim (1):
>       powerpc/pci: Fix boot panic on mpc83xx (regression)
> 
>  arch/powerpc/sysdev/fsl_pci.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
