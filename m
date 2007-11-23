Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 715BBDDDF5
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 15:43:26 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 22 Nov 2007 21:43:22 -0700
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 01/10] powerpc: Set up OF properties for ppc32 kexec
Message-ID: <20071123044322.GA2820@xyzzy.farnsworth.org>
References: <20071122154159.GA24711@xyzzy.farnsworth.org>
	<20071122154517.GA26340@xyzzy.farnsworth.org>
	<20071123091727.6e6fcd7a.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071123091727.6e6fcd7a.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 23, 2007 at 09:17:27AM +1100, Stephen Rothwell wrote:
> Hi Dale,
> 
> Just a nit ...
> 
> On Thu, 22 Nov 2007 08:45:17 -0700 Dale Farnsworth <dale@farnsworth.org> wrote:
> > +static struct property crashk_base_prop = {
> > +	.name = "linux,crashkernel-base",
> > +	.length = sizeof(unsigned long),
> > +	.value = &crashk_res.start, };

Heh.  How did that happen?  :)

I'll fix it as well as the alignment issues you mentioned.

Thanks Stephen.

-Dale
