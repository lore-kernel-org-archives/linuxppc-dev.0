Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: "Jack Liu" <Jack_liu@usish.com>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Network problem: Ping is OK, Yet telnet and ftp etc is not working
Date: Wed, 31 Mar 2004 15:45:18 -0300
References: <200403310303.i2V3366P010744@ms.usish.com>
In-Reply-To: <200403310303.i2V3366P010744@ms.usish.com>
MIME-Version: 1.0
Message-Id: <200403311545.18083.scop@digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wednesday 31 March 2004 00:02, Jack Liu wrote:
> hi,all
>
>      We use ADMTek AN983B chip as our network chip. And I have porting
> linux to this MPC8241 platform.Now I have a very strange problem:
>    If I ping my target, no answer. When I start tcpdump on my target,
> the ping ... works fine. Since the hardware is put into promiscuous
> mode when tcpdump is running, So I use ifconfig to put NIC work in
> promiscuous mode. I thought it can temporarily solve the problem. Now
> ping is OK. However When I telnet other machine, no answer.And When I
> telnet my target, still no answer. I thought it may because of firewall.
> So I undef CONFIG_NETFILTER in .config and autoconf.h. Still the same.
> So what could be the problem?

Well, check your interface's IP addressing for a wrong broadcast address; your
may also have a misconfiguration in your hardware's drivers,  related to the
the MAC address and/or broadcast address matching.

HTH,

--
Ricardo Scop.
rscop@matrix.com.br
+55 51 999-36-777
Porto Alegre, RS - BRazil


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
