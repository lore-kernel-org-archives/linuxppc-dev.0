Message-ID: <000601c15323$17398190$020aa8c0@dimbar>
From: "Nils Krueger" <nilz@hoschi.de>
To: <paulus@samba.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
References: <15302.40082.869098.88039@cargo.ozlabs.ibm.com>
Subject: Re: boot methods
Date: Fri, 12 Oct 2001 15:37:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Paul!

> I would like to make a complete list of the methods people use to boot
> the PPC/Linux kernel on different platforms.  As a start, here is what
> I can think of off the top of my head:

I have a Motorola PowerStack "Series E" PReP machine.

I can boot the zImage.prep from a "PPC PReP Boot" partition (type 41) having
written it to that partition using the dd command.

The PPCBug firmware has also the following options. I have only tested
booting from floppy.

- boot zImage from floppy disk, CD or tape (also directly written to it)
- network boot (tftp)

Nilz
--
http://www.hoschi.de/nilz   (Nilz' Homepage)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
