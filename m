From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15284.6801.507558.179571@cargo.ozlabs.ibm.com>
Date: Fri, 28 Sep 2001 16:37:05 +1000 (EST)
To: Mark Salisbury <mbs@mc.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc LE questions (seeking help hand info pointers)
In-Reply-To: <3BAA0E6F.5050503@mc.com>
References: <3BAA0E6F.5050503@mc.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark Salisbury writes:

> question 1.  are there already existing patch sets (rejected from
> mainline inclusion) available for use as a starting point?

Hmmm, I think there was someone who was looking at this, but I don't
recall who it was.

> question 3.  is there a general issue of endian safety in linux (I would
> think not) or just in the ppc-specific code?

Given that Linux runs on both big and little-endian machines, yes the
endian issues have largely been addressed, with the exception of some
drivers.

> question 4. assuming I was willing to deliver a clean, complete LE
> enabling patch (including devices that are relevant to me), as a compile
> time config option and maintain that patch, what would be the primary
> obstacle to inclusion in the main line.

It would depend on how much needed to be changed just for the benefit
of the LE machines, and how much it would complicate future
maintenance of the rest of the code.  If there are suddenly lots of
places where we have to do things differently now because of the
existence of the LE port, then that would make it easy for people to
break things in the future without realizing, and that would be a
reason for rejection.

I am not opposed to LE support but I would be opposed to large-scale
changes to the code for the sake of one platform which isn't widely
used - unless of course you can argue that the changes result in us
doing things the "right" way for all platforms.

It ultimately comes down to "show us the code".

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
