Message-ID: <3669C883.E34637EE@jlc.net>
Date: Sat, 05 Dec 1998 18:57:55 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org,
        Cort Dougan <cort@persephone.cs.nmt.edu>
Subject: Re: Mapping frame buffer using BAT
References: <Pine.HPP.3.96.981204113244.17076J-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:

> Not on PPC (at least 6xx/7xx), remember that the TLB are not....

You missed my points, so let me try again a little more specifically.
First, the MMU requires system resources to support, whether
it is processor registers, memory for page tables, bus cycles to
load translations, and processor instruction cycles to maintain
all of that.  This thread started by suggesting a modification
that reduced this system support.  My request was to simply
consider all PPC cores and a longer term better solution.

Second, a later discussion indiciated it was easy to dismiss
a particular enhancement.  My point was that you need to
evaluate that enchancement using more than one experiment,
perhaps trying to find one that specifically causes performance
challenges, and that it may be difficult to quantify.


> ...by adding code (which represent additional cache lines to fetch).

Just make sure you don't load them later, at a higher cost.  If
the cache doesn't provide a benefit, such as additional hits or
improved bus timing, then perhaps it should be disabled for those
parts of the system.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
