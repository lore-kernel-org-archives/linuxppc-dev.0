Message-ID: <395267CC.A286E1A0@wanadoo.fr>
Date: Thu, 22 Jun 2000 21:23:56 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Josh Huber <huber@mclx.com>
CC: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PPTP and mppe module
References: <20000622103704.A4900@mclx.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Josh Huber wrote:
[]
> Anyone tried getting a VPN client working on PPC?

Sure. France Telecom ADSL runs with pptp, and I have been using this for
quite a while. I compiled a Mandrake SRPM, pptp-adsl-fr-1.0.2-2mdk,
without any problem. There wasn't any kernel patching involved. My ppp
RPM is version 2.3.11, also compiled from a SRPM without problem. They
run with 2.2.17pre kernels as well as with 2.4.0-test1 kernels.

We discussed the include/linux/if_ppp.h problems already 2 weeks ago on
the list (maybe on linuxppc-user?). The one I get from both
linux-pmac-stable and from bitkeeper linux_2_2 via rsync has
#define PPP_VERSION     "2.3.7"
#define PPP_MAGIC       0x5002  /* Magic value for the ppp structure */
inside. It seems that others are able to get different versions from the
same rsync server. Mystery.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
