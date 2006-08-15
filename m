Return-Path: <hollis@penguinppc.org>
Subject: Re: [PATCH 0/6] bootwrapper: arch/powerpc/boot code reorg patches
From: Hollis Blanchard <hollis@penguinppc.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060808191450.GA10108@mag.az.mvista.com>
References: <20060719225356.GA3887@mag.az.mvista.com>
	<20060808191450.GA10108@mag.az.mvista.com>
Content-Type: text/plain
Date: Tue, 15 Aug 2006 14:37:06 -0500
Message-Id: <1155670626.6338.3.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-08-08 at 12:14 -0700, Mark A. Greer wrote:
> Just a note that I will respin my patches to address all of your
> comments.  However, it looks like the fdt code is going to change
> to use code from a common source base.  I'm going to wait until
> that has settled and then I'll modify the code and repost the patches.

By the way, I don't expect the (ft_build.h) interface to change much
from what I emailed last week. So I think it's safe to build on top of
those.

The only addition I'd like to make is creating an ft_set_prop() that
will handle resizing the tree for you. With that change, you wouldn't
ft_get_prop() and then write directly to that pointer (as is done
currently).

I'm still waiting to hear the outcome of Matt's patches. I don't need
them, but if u-boot does then I'll have to merge them into the
standalone code.

-Hollis
