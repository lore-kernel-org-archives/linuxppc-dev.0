Message-Id: <5.1.0.14.2.20030606101108.03646ec8@mail.ebshome.net>
Date: Fri, 06 Jun 2003 10:14:53 -0700
To: Magnus Damm <damm@opensource.se>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: x86(host) --> ppc(tgt) cross-tool-chain
Cc: brian.auld@adic.com, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030606190535.644a4939.damm@opensource.se>
References: <995FF289C9D69747A09E4299264459540C109867@penguin.adic.com>
 <995FF289C9D69747A09E4299264459540C109867@penguin.adic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 10:05 AM 6/6/2003, Magnus Damm wrote:

>but earlier versions of glibc (2.1.3) needed a patch to correctly
>support powerpc processors with 16-byte cachelines like the 4xx- and
>8xx-series.

Small correction, 405EP, 405GP, 405GPr (and probably all other 405 based
CPUs),
440GP, 440GX have _32_ byte cacheline.

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
