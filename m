Return-Path: <jose.franca@nsn.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: FW: SKB corruption on heavy traffic
Date: Wed, 30 Apr 2008 10:07:15 +0100
Message-ID: <56DEE2D3217CD946B290399093C8FA7C212E48@PTLIEXC001.nsn-intra.net>
From: "Franca, Jose (NSN - PT/Portugal - MiniMD)" <jose.franca@nsn.com>
To: <linuxppc-dev@ozlabs.org>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From our latest debugs we found that the problem occurs mainly on skbuff =
code. After some variable time kfree or kalloc result in kernel oops.

-----Original Message-----
From: Franca, Jose (NSN - PT/Portugal - MiniMD)=20
Sent: quarta-feira, 30 de Abril de 2008 9:44
To: 'ext Scott Wood'
Cc: =09
Subject: RE: SKB corruption on heavy traffic

Hello!

	Thank you for replying!
	It't quite dificult to say if the problem exists without our changes, =
since the all software is dependent on this changes so to work with the =
hardware. I can't answer to that right now on that, but I forgot to add =
one thing: we have ring buffer full problems on our fcc_enet driver from =
time to time. So, I think the problem could be on linux configurations =
(related to hw) because there is a lot of posts on the web related to =
problems similar to this (none of them has really solved the bottom =
problem).=20

Regards,
Filipe=20

-----Original Message-----
From: ext Scott Wood [mailto:scottwood@freescale.com]=20
Sent: ter=E7a-feira, 29 de Abril de 2008 20:15
To: Franca, Jose (NSN - PT/Portugal - MiniMD)
Cc: linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org
Subject: Re: SKB corruption on heavy traffic

On Tue, Apr 29, 2008 at 07:39:07PM +0100, Franca, Jose (NSN - =
PT/Portugal - MiniMD) wrote:
> 	We are developing a MPC8247 based telecom board (512MB), using
> linux 2.4 with some proprietary changes on IP stack and we are facing
> some problems when we have heavy traffic on our Ethernet interfaces...

Do you see these problems without the proprietary changes, and with a
current kernel?

-Scott
