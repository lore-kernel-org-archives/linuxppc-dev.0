Date: Thu, 6 Jun 2002 12:30:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: roger blofeld <blofeldus@yahoo.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Sungem bug or something else?
Message-ID: <20020606193039.GD14252@opus.bloom.county>
References: <20020406102410.14763@smtp.wanadoo.fr> <20020606192510.58822.qmail@web11106.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020606192510.58822.qmail@web11106.mail.yahoo.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 06, 2002 at 12:25:10PM -0700, roger blofeld wrote:

> I encounter an oops during boot bringing up a sungem
> interface. (smp g4 450/gcc 3.1/glibc 2.2.5) If I defer
> bringing up the network at boot, I can successfully
> start eth0 (sungem) if I start eth1 (tulip) first, so
> it may not be the sungem driver itself. This happens
> on benh 2.4.19-Bpre10, and pre9.

Have you tried gcc-3.0 or gcc-2.95 ?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
