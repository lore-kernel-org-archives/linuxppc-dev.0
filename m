Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <1187712684.13726.32.camel@pterry-fc6.micromemory.com>
References: <46C5519E.6010300@dutchspace.nl>
	<1187353616.2778.358.camel@shinybook.infradead.org>
	<46C5B288.2010308@dutchspace.nl>
	<1187361603.2778.382.camel@shinybook.infradead.org>
	<46C5B40F.5040209@dutchspace.nl>
	<acbcf3840708171628k242e96ffl2b65011bf6d39512@mail.gmail.com>
	<20070821052514.GC21169@localhost.localdomain>
	<ae3d7296a5c3e83f19817a04841d099f@kernel.crashing.org>
	<1187712684.13726.32.camel@pterry-fc6.micromemory.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <116C1903-CE42-4066-8524-F9216003BE9A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Patches for ppc?
Date: Tue, 21 Aug 2007 11:40:30 -0500
To: pterry@micromemory.com
Cc: Linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 21, 2007, at 11:11 AM, Phil Terry wrote:

> On Tue, 2007-08-21 at 17:14 +0200, Segher Boessenkool wrote:
>>> It's not a question of indivudual files being copied over -  
>>> things are
>>> done differently in arch/powerpc.  Things are gradually being ported
>>> over to arch/powerpc as people get the time - that's why arch/ppc
>>> isn't gone yet.
>>
>> And to be blunt, one of the points of arch/powerpc vs. arch/ppc is
>> to actually leave behind some stuff.  "If no one ports it, no one
>> wants it".
>
> So am I alone in getting a mixed message from "Linux community" to
> "embedded community"?
>
> On the one hand we have people like GKH telling embedded people to  
> stop
> being private company/device specific forks but to submit their  
> hardware
> to the tree where it will be supported "for free" by the kernel  
> hackers,
> saving us the "chore" of supporting "our" code through all the kernel
> changes and forever chasing it.
>
> On the other hand we have people telling us that because we are too  
> lazy
> to support "our" code the kernel guys aren't going to pull it forward
> for us.

There is clearly a balance here.  While I don't think too many people  
are going to disagree with GKH intent, there is a practicality about  
it.  If no kernel hacker has access to a particular board that was  
supported in arch/ppc and no one seems to care about it than it seems  
to be a candidate to not move forward.

> So in fact people 3rd party people like me are in between real  
> problems,
> we base our code on say a Freescale chip, who submit to the kernel to
> save their support issues and we base our code on that. Now, the
> Freescale guys are too busy porting their "latest" chips across the
> PPC/Powerpc divide to port the "old" stuff so it gets "left behind".
> That old stuff is still selling and the people who based code on it  
> had
> the expectation that the code would continue to be supported. So  
> now I'm
> being told not only to "port my stuff or lose it" but now also port
> freescale's stuff or lose it.

If there is some specific freescale board/chip that is being left  
behind that you're concerned about please let me know.

> And then we get beaten up because we "stayed" with "ancient stuff"  
> like
> 2.6.21!!!
>
> Not picking on Freescale, or Segher, just trying to wave the flag,  
> lots
> of people want it, they are just not all in a position to save it
> because we "embedded" people are by nature a fractured community of
> niche players with products that don't turn over with out customers
> every six months, some people will want to buy a product for years...
>
> And yes I do understand the "Linux kernel hackers are nothing more  
> than
> a group of diverse people from many companies so why is embedded any
> different" argument, I just don't have an answer right now other  
> than it
> is.

I'd ask you to mention specific boards/chip/functionality rather than  
generic statements so we can actual be aware of things we're  
forgetting or are important to people that we are not aware of.

The fact that arch/ppc is 'dead' has been posted on the lists  
numerous times to give people the opportunity to let us all know  
what's important to people.

- k
