Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Init hangs
Date: Thu, 5 Aug 2004 17:28:52 +0200
References: <20040805103324.9CA4EC109F@atlas.denx.de>
In-Reply-To: <20040805103324.9CA4EC109F@atlas.denx.de>
Cc: "PPC_LINUX" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408051728.52442.Schramel.Linux@go.bartec.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Wolfgang,

thanks for your reply.

> > my kernel hangs by initializing the system. My target is mpc8270-based. I use ELDK 3.0 and mount my root-fs over nfs.
> > Denx-kernel 2.4.25.
> ...
> > It seems like it hangs in "run_init_process("/sbin/init");" or the /sbin/init - file does not work.
> > Sometimes the message "INIT: version 2.84 booting" is showed. And after printing this message it hangs, too.
> > But the most times it looks like above.
> >
> > Any ideas?
>
> Run ethereal and have a look at  the  network  traffic.  Check  which
> files get loaded and/or accessed. This might give you an idea.

i started ethereal and saw that the NFS read calls from target to host, are answered with two IP "fragmented IP protocols" by the host,
followed by a NFS read reply [Unreassembled Packet] by the host, too. And that goes on and on until the connection is dead.
I am not sure whether the fragmentation of ip in two packets is correct? There is no additional traffic it is "only" mounting and using rootfs over NFS.

Can you help me ?

Thanks
Marco






---------
Marco Schramel
R&D
Bartec GmbH
Schulstr. 30
94239 Gotteszell, Germany
www.bartec.de
Marco.Schramel@go.bartec.de
Phone:  +49 (0)9929/301332
Fax:    +49 (0)9929/301112

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
