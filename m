Message-ID: <39119F4D.FD8C4DD1@embeddededge.com>
Date: Thu, 04 May 2000 12:03:25 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: LinuxPPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] Adding support for LXT971/2 PHYs
References: <20000504070144.BD6A53C972@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:
>
> Hi Dan & friends,
>
> The following patch to the Fast Ethernet Controller driver adds support for
> the LXT971 and LXT972 PHYs,

Oooops, you almost missed out :-).  I have received a couple of these
lately, all implemented slightly differently.  I am going to shake-n-bake
all of these and see what falls out of the bag.......

I'll put it into the 2.3.99 tree first, then into one of the 2.2.xx
releases.



> I've also taken the liberty of moving the PHY interrupt definition

Well, everyone seems to want this someplace other than where it is,
but no one wants it in the same place.

> ........, allowing me to replace one of
> the #ifdef CONFIG_FADS

I think the #ifdefs for 8xx are soon going to be gone, replaced with
a significantly larger board information structure.  Things like this
will go there.  The #define IMMR is going to disappear, replaced with
a memory pointer, among other things.



> I'm pretty sure that the "This version of the driver is specific to the
> FADS..." comment in the header is old and incorrect,


That's not the only one :-).  When I see these, I try to update them,
but all too often I am worried about "line 1503" and don't pay attention
to the comments.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
