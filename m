From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Robert P. J. Day" <rpjday@mindspring.com>,
	"Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 2.6.5 kernel build: 'macro "mfmsr" passed 1 arguments, but takes just 0'
Date: Sat, 8 May 2004 15:37:52 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHCENOCFAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.LNX.4.58.0405080817270.10599@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>   as did someone else on this list recently, i did a first attempt at
> compiling the stock 2.6.5 kernel for an MPC8xx board.  from a verbose
> build:
> ====================================================================
> ...
[SNIP]

The stock kernel is not up to date. Use the PPC tree, http://ppc.bkbits.net:8080/linuxppc-2.5,
instead. That tree should compile, but still has run time problems.

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
