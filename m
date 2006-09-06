Return-Path: <mgreer@mvista.com>
Date: Wed, 6 Sep 2006 11:14:02 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: common flatdevtree code
Message-ID: <20060906181402.GB4129@mag.az.mvista.com>
References: <20060831184020.GA13494@mag.az.mvista.com>
	<17662.17895.852128.729679@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17662.17895.852128.729679@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 06, 2006 at 01:52:07PM +1000, Paul Mackerras wrote:

Hi Paul,

> Mark A. Greer writes:
> 
> > I'm doing some fairly massive rework to my patches so it'll take
> > another day or two (plus 4 day weekend for me).  In the meantime,
> > this is what I've done to your code.  :)
> 
> Any further progress on this?  I need an ft library for the prep
> bootwrapper changes I'm planning.

Yes, I'm preparing patches right now (need a few more hours though).

> I don't like the approach of doing a malloc for the whole blob every
> time you make a property larger though.  I'm going to be adding quite
> a few nodes and properties, potentially, and with a simple-minded
> malloc (such as you get in a bootwrapper) it's likely to chew through
> a lot of memory unnecessarily.  I would rather be able to start with
> an existing blob and pull it apart once, add stuff to it, then put it
> back together, doing a small number of mallocs in the process.

Yes, we definitely need a smarter approach.  I'll post the patches of
what I have now and we can go from there.

> > I still plan on changing it a bit to use ft_next in a few more routines
> > (e.g., ft_dump_blob).  ft_next has a clumsy interface but I like the fact
> 
> The interface might look nicer if we had a structure for the tag,
> name, value and length.  Then there would only be one parameter
> instead of the four you have at the moment.

That's a good idea.  I'll do that before posting the patches.

Mark
