Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] arch/ppc/8xx_io/enet.c
Date: Wed, 23 Oct 2002 13:44:42 -0200
References: <200210230751.g9N7pN4d024262@blooper.utfors.se> <02102313323200.01073@scop.digitel.com.br>
In-Reply-To: <02102313323200.01073@scop.digitel.com.br>
MIME-Version: 1.0
Message-Id: <02102313444201.01073@scop.digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wednesday 23 October 2002 13:32, Ricardo Scop wrote:
> On Wednesday 23 October 2002 05:51, Joakim Tjernlund wrote:
[snip]

> > No comments so far, no one interested in this?
>
> I'm interested! Indeed, I adapted and tested your patch in a 8260 FCC fast
> ethernet driver and it worked fine  I had a 20% increase in routing
> throughput with the  patch installed!
>
I forgot to mention the bad news. The increase mentioned above was obtained
with large packets (1500 bytes) traversing our board. With very small packets
(64 bytes), we  experimented a 10% DEcrease in PPS (packets per second).
We're still testing, but I guess the overall performance will be better with
the patch installed.

-Scop

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
