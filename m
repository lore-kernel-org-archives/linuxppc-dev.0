Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <001801c25ed6$1c389e00$7301a8c0@zhongqx>
From: "zhongqx" <zhongqx@guoguang.com.cn>
To: "Dave Ellis" <DGE@sixnetio.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <00512BA4F9D3D311912A009027E9B8F407E489@NT>
Subject: Re: Why FEC and SCC1 can not work at the same time?
Date: Wed, 18 Sep 2002 13:42:00 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sir,
   thank you very much,
   what you said is very right,fix ppcboot just like you said,and the proplem disappear!
   thank you again!
----- Original Message -----
From: "Dave Ellis" <DGE@sixnetio.com>
To: "'zhongqx'" <zhongqx@guoguang.com.cn>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, September 18, 2002 4:20 AM
Subject: RE: Why FEC and SCC1 can not work at the same time?

> On Tuesday, September 17, 2002 zhongqx wrote:
> > Now I meet a new problem! it is very strange!
> > I want to use FEC(100M) and SCC1(10M) interface,but they can
> > not work together.
> >      When I use ppcboot with CONFIG_SCC1_ENET defined , boot
> > linux ,then SCC1 is ok,when I ping FEC (I config it ip
> > address is 192.168.2.221) it displayed messaged "time out".
> >      When I use ppcboot with CONFIG_FEC_ENET  defined,  boot
> > linux ,then FEC is ok, when I
> > ping SCC( I config it ip address is 192.168.1.198) it
> > displayed messaged also "time out".
>
> For FADS PPCBoot sets up both BCSR1 and BCSR4 in cpu/mpc8xx/scc.c.
> In Linux 2.4.18 only BCSR1 is configured in arch/ppc/8xx_io/enet.c
> Maybe configuring BCSR4 in enet.c would help.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
