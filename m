Message-ID: <39EDE44B.255E686C@blastoff.com>
Date: Wed, 18 Oct 2000 10:56:28 -0700
From: "Tod E. Kurt" <tod@blastoff.com>
MIME-Version: 1.0
To: Zhaobin Zhu <zzhu@emc.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: LIST_HEAD
References: <Pine.LNX.4.21.0010171929100.19158-100000@gemini.home.net> <39EDD92F.BEC83BEB@emc.com> <39EDE34C.92EF5699@blastoff.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ooops, I meant:

    demo% grep -C LIST_HEAD /usr/include/linux/*.h

which should be the same as:

    demo% grep -C LIST_HEAD /usr/src/linux/include/linux/*.h


"Tod E. Kurt" wrote:
>
> Try this:
>
>    demo% grep -C LIST_HEAD /usr/src/linux/*.h
>
> Zhaobin Zhu wrote:
> >
> > Hi,
> >
> > What does LIST_HEAD do in drivers/pci/pci.c ?
> >
> >      LIST_HEAD(pci_root_buses);
> >      LIST_HEAD(pci_devices);
> >
> > Thanks,
> >
> > --
> >  Zhaobin Zhu
> >

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
