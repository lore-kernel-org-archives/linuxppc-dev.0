From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux 2.6 on MPC5200. Early problems  + 2.4 questions
Date: Mon, 8 Mar 2004 08:43:26 +0100
References: <40486C64.80803@246tNt.com> <4048B287.6010501@246tNt.com>
In-Reply-To: <4048B287.6010501@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403080843.26481.g.jaeger@sysgo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

On Friday 05 March 2004 18:01, Sylvain Munaut wrote:
[SNIPSNAP]
> My questions currently are :
>  - Apparently 0xf0000000 is mapped to somewhere ( the MBAR ) but I don't
> see where it's done ... And how do I tell it that it's IO and should not
> be cached. Apparently on 2.4 it works but I don't see where is the piece
> of code that just does that ...

checkout kernel/mpc5xxx_common.c

Ciao,
  Gerhard

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
