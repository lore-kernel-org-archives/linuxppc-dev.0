Date: Mon, 18 Oct 1999 18:38:24 -0500
From: Grant Erickson <grant@lcse.umn.edu>
To: Daniel Nilsson <daniel.n.nilsson@home.se>
cc: Adrian Cox <apc@agelectronics.co.uk>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Support for IBM CPU's ?
In-Reply-To: <380B935A.78031DBB@home.se>
Message-ID: <Pine.SGI.4.10.9910181830040.93278-100000@brule.lcse.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 18 Oct 1999, Daniel Nilsson wrote:
> So is the recommendation then to buy this [TiVo] CD and so [sic] what
> comes out of it?
> 
> Or should I help to do the IBM port instead ?

Daniel,

I've spoken to some people at TiVo and I should hopefully have a copy of
the CD within the end of the week.

I asked point blank if they planned on releasing their code back to the
PowerPC developer community in a manner beyond releasing this CD and they
said "no". To further clarify that response I asked if they planned to
integrate their sources with the rest of Linux/PPC source tree and they
said "no".

They are shipping a stable product, so I'm going to assume that their port
is pretty solid and will serve as a useful base to jump start 4XX efforts
(they commented that they've based their sources on a fairly old kernel
revision but didn't comment on which one).

That said, I think our collective efforts are best focused on integrating
the TiVo changes, updating it to the 2.3 kernel tree and then working on
testing and evaluating it (and making more board specific ports such as
the IBM "Oak" evaluation board).

Regards,

Grant


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
