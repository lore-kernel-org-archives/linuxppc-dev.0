Date: Thu, 28 Jun 2001 02:46:00 -0400 (EDT)
From: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
To: Michael Habermann <MHabermann@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Segmentation fault while dynamic linking
In-Reply-To: <5.0.2.1.0.20010628105509.02f18120@pop.gmx.de>
Message-ID: <Pine.LNX.3.95.1010628024351.5112B-100000@november.bhjjh.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 28 Jun 2001, Michael Habermann wrote:

>
> At 10:08 AM 6/27/2001 -0700, Matthew Locke wrote:
>
> >There are two places cacheline size affects glibc.  The one above that
> >you already found and in the glibc ppc optimized memset or memcpy (don't
> >remember which one).  you can just delete the ppc specific memset and
> >configure will pull in the generic memset.
>
> Yeah, deleting memset.S solved my problem.
>
> Thanks to you and the guys who answered by private mail.

Could you post a quick summary of what yo had to do to get this to work
(ie, which source you downloaded, which patches you downloaded and
applied, and which flags you used to compile)?

I've been trying to get uClibc to work, but am having IO errors with it,
so I'm thinking of giving glibc another try.

Thanks,
--Gus


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
