Message-Id: <200210230751.g9N7pN4d024262@blooper.utfors.se>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] arch/ppc/8xx_io/enet.c
Date: Wed, 23 Oct 2002 09:51:22 +0200
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Monday 21 October 2002 15:13, Joakim Tjernlund wrote:
> Hi
>
> Here is a patch to drop the expensive memcpy of received ethernet frames in
> interrupt context. I have not done any bench marking, but mounting a NFS
> rootfs feels faster.
>
> I am using a heavily modified enet.c in my system, but I think I got the
> patch correct.
>
> Also fixed a bug in set_multicast_list(), move the dmi list forward when
> walking it(dmi = dmi->next;)
>
> Comments? Anyone care to do some benchmarking?

No comments so far, no one interested in this?

A question, why do enet.c pass bad frames to netif_rx? Only late collisions
are disregarded, the rest is passed on.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
