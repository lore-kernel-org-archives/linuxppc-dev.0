Message-ID: <371E0DB4.4D0EB787@jlc.net>
Date: Wed, 21 Apr 1999 13:41:08 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Alexander Larsson <alex@signum.se>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Embedded 8xx 2.2.5 kernel tarball
References: <Pine.LNX.4.04.9904211803010.6664-100000@tammy.signum.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Alexander Larsson wrote:

> I just merged my local changes with the 2.2.5-embedded sources.
> I get an error when starting init. (Booting from nfs.)
>
> It just says:
> Freeing unused kernel memory: 32k init
> put_dirty_page: page already exists

Ummm.....it would help if I knew a little more about what you are using.
Like, what kind of board and the kernel configuration?

I would see a similar problem when I would configure IDE and not
configure PCI.  This is because the IDE probes (and other I/O in/out
operations) map to real memory locations and tend to write on top of
kernel data structures.  This is my only guess without more information.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
