Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Oliver Fuchs" <olivers.lists@gmx.net>
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Date: Mon, 16 Aug 2004 16:00:32 +0200
MIME-Version: 1.0
Subject: Re: MPC82xx enet on SCC3
Message-ID: <4120DA20.2984.1BD2DC2@localhost>
In-reply-to: <66FD1720-EC80-11D8-8A46-003065F9B7DC@embeddededge.com>
References: <411B9AF9.12494.1DA4A94@localhost>
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


From:           	Dan Malek <dan@embeddededge.com>
Subject:        	Re: MPC82xx enet on SCC3

> > as far as I understand, my kernel (2.4.24 from ELDK3.0) is not
> > prepared for Ethernet on SCC3 of the MPC82xx.
>
> An #ifdef and two lines of #defines should be all you need,
> unless you have some special BSCR or other set up needed.
>
Ok, it was a little bit more, but I have it.
I have modified arch/ppc/config.in and arch/ppc/8260_io/enet.c so
that it fits to SCC1-4 w/o further modifications there.

I would contribute this, if anyone wants to use it.
But as Wolfgang has mentioned frequently, it only makes sense to
contribute a patch that aplies to the latest CVS version.
Is there any chance to get the latest CVS version by HTTP or FTP?

Oliver

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
