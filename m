Return-Path: <dale@farnsworth.org>
Resent-Message-ID: <20070503051037.GA7936@xyzzy.farnsworth.org>
Date: Wed, 2 May 2007 22:08:22 -0700
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc: check cache coherency of kernel vs firmware
Message-ID: <20070503050822.GA7491@xyzzy.farnsworth.org>
References: <20070502215938.GF27253@xyzzy.farnsworth.org>
	<20070503132824.76b15c67.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070503132824.76b15c67.sfr@canb.auug.org.au>
Cc: Linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 03, 2007 at 01:28:24PM +1000, Stephen Rothwell wrote:
> On Wed, 2 May 2007 14:59:38 -0700 "Dale Farnsworth" <dale@farnsworth.org> wrote:
> >
> > +#ifdef CONFIG_CHECK_CACHE_COHERENCY
> > +#endif /* CONFIG_CHECK_CACHE_COHERENCY */
> 
> These ...
> 
> > +config CHECK_COHERENT_CACHE
> 
> don't match this.

Oops.  Brown paper bag time.

Thanks,
-Dale
