Message-ID: <39682BD2.C34BE171@amulet.co.jp>
Date: Sun, 09 Jul 2000 16:37:54 +0900
From: Hollis Blanchard <hollis@amulet.co.jp>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: yellowdog-devel@lists.yellowdoglinux.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: Changing default partition type for linux/ppc
References: <Pine.LNX.4.10.10007071754400.28685-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
>
> >
> > Well, they don't at this point. For example in partitioning tool in
> > LinuxPPC 2000, LinuxPPC Inc decided it would be better to use the type
> > "Linux_PPC". This works (in that nothing gets overwritten, corrupted,
> > etc) but has the disadvantage that no other software knows anything
> > about that type.
>
> So can we get all distributions to agree on this partition type scheme?
[snip]
> LinuxPPC 1999 used the same type, and I think the 2000 change is a bad
> thing. What are YellowDog and SuSE using?

I agree. So far the Linux "standard" has been to pretend to be A/UX
partitions. To my knowledge, every distribution with the exception of
LinuxPPC 2000 uses Apple_UNIX_SVR2. (And I'm not sure that alteration
was especially well thought out.)

> Benh: are you maintaining the official version of pdisk now?

That would be Eryk Vershen <eryk@cfcl.com>, who recently resurfaced in
February
(http://lists.linuxppc.org/listarcs/linuxppc-user/200002/msg01471.html).



So now that the conversation's died down, it seems like everybody's
happy with "Linux" (Mark Hatle's suggestion was for "Linux_*") and
"Linux_swap".

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
