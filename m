Date: Sat, 5 May 2001 00:03:05 -0400 (EDT)
From: Daniel Berlin <dan@www.cgsoftware.com>
To: Ira Weiny <iweiny@acm.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ieee1394 status
In-Reply-To: <3AF3551D.3627FFBC@acm.org>
Message-ID: <Pine.LNX.4.33.0105042358480.6265-100000@www.cgsoftware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 4 May 2001, Ira Weiny wrote:

>
> Has anything more been done on the ieee1394 since March?

I'm about to submit a general endinaess patch tot he ieee1394 guys.

The problem is that you need different combinations of swapping for
different OHCI implementations, because the standard didn't specify a few
things it should have.

 I've been using 2 45 gig firewire drives using LVM
and XFS for months now.

I've been using a cd-rw firewire drive for about 3 days now, too.
>Back  then
> there was a big discussion about some patches and fixes for endianess.
> Did these make it into Ben's rsynced tree?
>
> I am trying to do some work with 1394 on my Titanium and it seems to
> self id correctly but there are problems when trying to read from the
> bus.  I am assuming a problem in the OHCI driver since my G3 did not
> have these problems last night with the pcilynx driver.  (And I can't
> verify that until next week when I get back to it.  Sorry)

Errr, this is pretty easy to fix.

In fact, it's what my patch fixes.

You can say whether you want the following swapped  or not (in any
combination, they are just flags)

1. selfid handling
2. reading
3. writing


Pismo needs 2 and 3 to work right.
Other OHCI on PPC (TI) need 1, 2, and 3.
Your titanium probably needs 2 and 3, since i believe it's based on the
uninorth, just a newer revision, right?

>
> Should I dig into this further?  Is there a tree with newer 1394 code in
> it?

It'll be on the 1394 list in about 10 minutes.

> Ira
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
