In-Reply-To: <Pine.SGI.4.02A.9902011514570.11398-100000@myst.ee.qub.ac.uk>
Date: Mon, 1 Feb 1999 20:14:48 +0100
To: Owen Waller <O.Waller@ee.qub.ac.uk>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: matroxfb, anybody? (More details...)
Message-Id: <19990201201448.020647@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 1, 1999, Owen Waller <O.Waller@ee.qub.ac.uk> wrote:

>If I have two idential video boards in my Mac one "mac" specific which
>shows up in the OF tree, and one that is x86 sourced and doesn't show up
>under OF how can we initialise both boards correctly.

It will not appear in OF as a display device and may not appear with a
name, but are you sure it doesn't appear at all under it's generic
pciXXXX,YYYY name ? (where XXXX is the vendorID and YYYY the deviceID).


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
