Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18448.10563.385481.904182@cargo.ozlabs.ibm.com>
Date: Thu, 24 Apr 2008 16:31:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH] powerpc TLF_RESTORE_SIGMASK
In-Reply-To: <20080423063753.C2088270381@magilla.localdomain>
References: <20080403210842.6C88C26F98D@magilla.localdomain>
	<18446.50037.964682.539009@cargo.ozlabs.ibm.com>
	<20080423063753.C2088270381@magilla.localdomain>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland McGrath writes:

> > This should be _TLF_RESTORE_SIGMASK (leading '_'), I think.
> 
> Indeed so.  Here's a replacement patch.

Thanks.  That can't go in until some generic changes have gone in
first, right?  So are you going to push the lot in one go via Andrew,
or should I wait until the generic part is upstream and then push the
powerpc bit?

Paul.
