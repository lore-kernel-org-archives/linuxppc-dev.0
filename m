Date: Mon, 1 Feb 1999 19:30:37 -0100
From: Owen Waller <O.Waller@ee.qub.ac.uk>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: Owen Waller <O.Waller@ee.qub.ac.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: matroxfb, anybody? (More details...)
In-Reply-To: <19990201201448.020647@mail.mipsys.com>
Message-Id: <Pine.SGI.4.02A.9902011930050.11398-100000@myst.ee.qub.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,

> >If I have two idential video boards in my Mac one "mac" specific which
> >shows up in the OF tree, and one that is x86 sourced and doesn't show up
> >under OF how can we initialise both boards correctly.
> It will not appear in OF as a display device and may not appear with a
> name, but are you sure it doesn't appear at all under it's generic
> pciXXXX,YYYY name ? (where XXXX is the vendorID and YYYY the deviceID).

I don't think so but I'll double check tonight.

Thanks

-------------------------------------------------------------------------
Owen Waller                     |   "...sometimes I think I'm a little
PhD. Student in Control Eng.    |    more English than I am French..."
Queens University               |              - Alain Prost 
Belfast                         |
Tele: +44 (0)1232 274085        |    Fax: +44 (0)1232 667023


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
