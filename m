Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] BUILD_BUG_ON: make it handle more cases
Date: Thu, 5 Nov 2009 17:07:15 +1030
References: <4AC1E15502000078000516B5@vpn.id2.novell.com>
	<20091105112020.33f02552.sfr@canb.auug.org.au>
	<200911051658.36265.rusty@rustcorp.com.au>
In-Reply-To: <200911051658.36265.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <200911051707.15561.rusty@rustcorp.com.au>
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

On Thu, 5 Nov 2009 04:58:36 pm Rusty Russell wrote:
> I did a 4.3.3 allmodconfig with this patch on 64-bit a few days back and all
> was fine.  Will try 4.4.0 now.

4.4.1 seems OK (Ubuntu).

This is annoying.  But I'll withdraw the patches; if there's another reason
that 4.4.0 is bad, we can ban it and reintroduce this.  I don't think that
breaking this hack is enough to declare 4.4.0 verboten.

Thanks,
Rusty.
