Message-ID: <00512BA4F9D3D311912A009027E9B8F407E489@NT>
From: Dave Ellis <DGE@sixnetio.com>
To: "'zhongqx'" <zhongqx@guoguang.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Why FEC and SCC1 can not work at the same time?
Date: Tue, 17 Sep 2002 16:20:44 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tuesday, September 17, 2002 zhongqx wrote:
> Now I meet a new problem! it is very strange!
> I want to use FEC(100M) and SCC1(10M) interface,but they can
> not work together.
>      When I use ppcboot with CONFIG_SCC1_ENET defined , boot
> linux ,then SCC1 is ok,when I ping FEC (I config it ip
> address is 192.168.2.221) it displayed messaged "time out".
>      When I use ppcboot with CONFIG_FEC_ENET  defined,  boot
> linux ,then FEC is ok, when I
> ping SCC( I config it ip address is 192.168.1.198) it
> displayed messaged also "time out".

For FADS PPCBoot sets up both BCSR1 and BCSR4 in cpu/mpc8xx/scc.c.
In Linux 2.4.18 only BCSR1 is configured in arch/ppc/8xx_io/enet.c
Maybe configuring BCSR4 in enet.c would help.

Dave

Dave Ellis
~~~~~~~~~~~~~~~~~~~~~~~~~~
SIXNET - "Leading the Industrial Ethernet Revolution"
331 Ushers Road,   P.O. Box 767, Clifton Park, NY 12065 USA
Tel +1 (518) 877-5173   Fax +1 (518) 877-8346
Email me at: dge@sixnetio.com
Detailed product info: www.sixnetio.com
~~~~~~~~~~~~~~~~~~~~~~~~~~

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
