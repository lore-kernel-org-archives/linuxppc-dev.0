Message-ID: <399A3E0F.EA9685E9@wanadoo.fr>
Date: Wed, 16 Aug 2000 09:09:03 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: toa@pop.agri.ch
CC: Jack Howarth <howarth@bromo.med.uc.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: bk 2.4-test7 broken
References: <200008150304.UAA31773@bromo.med.uc.edu> <39992943.C267C4CB@wanadoo.fr> <399989FD.29EFBABA@pop.agri.ch> <3999BA6D.C7C249B0@pop.agri.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andreas Tobler wrote:
[]
> A previous test on linux-pmac-devel(2.4.0-test5) was successful (until
> to the adaptec...), so I tought the changes got in in bk too. Nop, a
> reminder on a previous mail from Takashi I checked the time.c in
> arch/ppc/kernel. The 'mftb' call is still there..... (which the 601
> doesn't likes/understands)
>
> So I think a merge between linuxcare-devel and bk isn't done up to now...

Just for the record: I compiled and run OK both
- linux-pmac-devel as rsynced right now (version 2.4.0-test6)
- linux-bk-devel as of 3 days ago (version 2.4.0-test5)

For those of you who get up to "freeing kernel memory": Did you see the
patch on the linux-kernel mailing list for fs/exec.c
http://boudicca.tux.org/hypermail/linux-kernel/latest/0266.html?
A similar patch is contained in the latest (test7-pre4) patch from
Linus.

I am now trying to back out the recent changes to softirq&Cie...

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
