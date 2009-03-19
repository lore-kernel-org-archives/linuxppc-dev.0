Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: cpus4096 tree build failure
Date: Thu, 19 Mar 2009 21:37:14 +1030
References: <20090319215300.1833d28e.sfr@canb.auug.org.au>
In-Reply-To: <20090319215300.1833d28e.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200903192137.15209.rusty@rustcorp.com.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>,
	linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 19 March 2009 21:23:00 Stephen Rothwell wrote:
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 19 Mar 2009 21:35:24 +1100
> Subject: [PATCH] powerpc: mmzone.h needs cpumask_t to be defined
> 
> Commit 082edb7bf443eb8eda15b482d16ad9dd8137ad24 ("numa,cpumask: move
> numa_node_id default implementation to topology.h") removed the include
> of linux/topology.h from linux/mmzone.h which exposed this lack.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Rusty Russell <rusty@rustcorp.com.au>

Ingo, please apply.

Apparently sparc is similarly broken :(

Rusty.
