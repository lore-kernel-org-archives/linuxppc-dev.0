Return-Path: <hollisb@us.ibm.com>
Subject: Re: common flatdevtree code
From: Hollis Blanchard <hollisb@us.ibm.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060907182717.GC4398@mag.az.mvista.com>
References: <20060831184020.GA13494@mag.az.mvista.com>
	<17662.17895.852128.729679@cargo.ozlabs.ibm.com>
	<20060907003625.GA15533@mag.az.mvista.com>
	<1157615011.18137.14.camel@diesel>
	<20060907182717.GC4398@mag.az.mvista.com>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 17:23:36 -0500
Message-Id: <1157667816.5220.30.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-09-07 at 11:27 -0700, Mark A. Greer wrote:
> 
> On Thu, Sep 07, 2006 at 02:43:31AM -0500, Hollis Blanchard wrote:
> > 
> > On Wed, 2006-09-06 at 17:36 -0700, Mark A. Greer wrote:
> > > void *ft_find_device(const void *bphp, const char *srch_path)
> > 
> > How about "ft_find_node"?
> 
> Sure.
> 
> > I renamed that and made a couple other small
> > changes. In particular:
> > - u8->int
> 
> OK.
> 
> > - exit and free -> ft_exit and ft_free (so they can be wrapped in
> > flatdevtree_env.h)
> 
> Makes sense.
> 
> > - moved those inlines out of flatdevtree.h, since they don't need to be
> > exported
> 
> ft_parentize is also used in flatdevtree_misc.c so I think they
> should stay in flatdevtree.h. 

OK.

I've pushed these changes and a couple more (run hg pull -u to update).

-- 
Hollis Blanchard
IBM Linux Technology Center
