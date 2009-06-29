Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 665FCB70F2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 02:01:58 +1000 (EST)
Message-ID: <4A48E564.6020904@am.sony.com>
Date: Mon, 29 Jun 2009 09:01:40 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 05/62] arch/powerpc: Remove unnecessary semicolons
References: <cover.1246173664.git.joe@perches.com>
	<a55afa18f8b7ba8343072a14d36a2e340e61e816.1246173680.git.joe@perches.com>
In-Reply-To: <a55afa18f8b7ba8343072a14d36a2e340e61e816.1246173680.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: trivial@kernel.org, Robert Richter <robert.richter@amd.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	oprofile-list@lists.sf.net, Andrew Morton <akpm@linux-foundation.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/28/2009 09:26 AM, Joe Perches wrote:
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/powerpc/mm/tlb_hash64.c                 |    2 +-
>  arch/powerpc/oprofile/cell/vma_map.c         |    2 +-
>  arch/powerpc/platforms/powermac/cpufreq_64.c |    2 +-
>  arch/powerpc/platforms/powermac/pic.c        |    2 +-
>  arch/powerpc/platforms/ps3/system-bus.c      |    1 -
>  arch/powerpc/sysdev/fsl_rio.c                |    2 +-
>  arch/powerpc/sysdev/ppc4xx_pci.c             |    4 ++--
>  7 files changed, 7 insertions(+), 8 deletions(-)

For ps3/system-bus.c only.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
