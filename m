Return-Path: <miltonm@bga.com>
Date: Thu, 3 Aug 2006 00:57:36 -0500
From: Milton Miller <miltonm@bga.com>
To: paulus@samba.org, mgreer@mvista.com, Linuxppc-dev@ozlabs.org,
Subject: Re: [PATCH 1/6] bootwrapper: arch/powerpc/boot code reorg
Message-Id: <31154584656643c98694.1714636915.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed Aug  2 2006 01:15:05 AM CDT, Paul Mackerras wrote:
> I wrote:
> 
> > The ops structure seems like a reasonable concept, but I question
> > whether we need to have platform_ops separate from fw_ops, since the
> > firmware is essentially part of the implementation of the platform.
> > Also I don't see why we need to do a double indirection to get to each
> > ops function.
> 
> Thinking about this a bit more, why do we need the indirect function
> calls at all?  Do we ever want to be able to choose (e.g.) one of
> several possible console implementations at runtime?  Don't we know at
> compile time which one we will be using, and thus can't we use the
> linker to make the necessary linkages?
> 


Personally, I would like to consider a zImage that could be either an open
firmware client or a kexec kernel.  However, I'm not sure that requires the
full ops set.  I just did the seperate image to get the function I needed quickly.

Also, were not some of the ops pre-existing?

milton
