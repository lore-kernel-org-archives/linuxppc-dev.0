Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] BUILD_BUG_ON: make it handle more cases
Date: Fri, 6 Nov 2009 17:00:26 +1030
References: <4AC1E15502000078000516B5@vpn.id2.novell.com>
	<200911051658.36265.rusty@rustcorp.com.au>
	<20091105173842.c94ba501.sfr@canb.auug.org.au>
In-Reply-To: <20091105173842.c94ba501.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200911061700.27493.rusty@rustcorp.com.au>
Cc: Hollis Blanchard <hollisb@us.ibm.com>, linux-kernel@vger.kernel.org,
	kvm-ppc@vger.kernel.org, linux-next@vger.kernel.org,
	Jan Beulich <JBeulich@novell.com>, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 5 Nov 2009 05:08:42 pm Stephen Rothwell wrote:
> Hi Rusty,
> 
> On Thu, 5 Nov 2009 16:58:36 +1030 Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > Huh?  virtio_has_feature does:
> > 
> > 	if (__builtin_constant_p(fbit))
> > 		BUILD_BUG_ON(fbit >= 32);
> > 	else
> > 		BUG_ON(fbit >= 32);
> 
> In Linus' tree (and linux-next) it looks like this:

Ah.  My patch series fixes that as part of removing MAYBE_BUILD_BUG_ON.

I've put both in for linux-next.

Cheers,
Rusty.
