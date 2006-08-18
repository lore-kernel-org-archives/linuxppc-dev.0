Return-Path: <mgreer@mvista.com>
Date: Fri, 18 Aug 2006 14:46:50 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Hollis Blanchard <hollis@penguinppc.org>
Subject: Re: [PATCH 0/6] bootwrapper: arch/powerpc/boot code reorg patches
Message-ID: <20060818214649.GA30418@mag.az.mvista.com>
References: <20060719225356.GA3887@mag.az.mvista.com>
	<20060808191450.GA10108@mag.az.mvista.com>
	<1155670626.6338.3.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1155670626.6338.3.camel@basalt.austin.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 15, 2006 at 02:37:06PM -0500, Hollis Blanchard wrote:
> On Tue, 2006-08-08 at 12:14 -0700, Mark A. Greer wrote:
> > Just a note that I will respin my patches to address all of your
> > comments.  However, it looks like the fdt code is going to change
> > to use code from a common source base.  I'm going to wait until
> > that has settled and then I'll modify the code and repost the patches.
> 
> By the way, I don't expect the (ft_build.h) interface to change much
> from what I emailed last week. So I think it's safe to build on top of
> those.
> 
> The only addition I'd like to make is creating an ft_set_prop() that
> will handle resizing the tree for you. With that change, you wouldn't
> ft_get_prop() and then write directly to that pointer (as is done
> currently).
> 
> I'm still waiting to hear the outcome of Matt's patches. I don't need
> them, but if u-boot does then I'll have to merge them into the
> standalone code.

Another note.  Hollis and I have been talking some more and may change
some code.  IOW, I'm still going to wait a bit to see what comes out of
it before respining the patches.

Mark
