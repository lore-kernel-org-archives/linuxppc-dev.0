From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Timothy A. Seufert" <tas@mindspring.com>,
	Christopher Murtagh <christopher.murtagh@mcgill.ca>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: SMP/HIGHMEM/7450 status ?
Date: Thu, 6 Jun 2002 21:46:36 +0200
Message-Id: <20020606194636.7979@smtp.wanadoo.fr>
In-Reply-To: <a05111b00b92567b867f3@[10.0.0.42]>
References: <a05111b00b92567b867f3@[10.0.0.42]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Apple did hold off on dual 7450 until rev 2.1 came out and fixed some
>of the nastier SMP errata, so presumably they at least thought there
>were no SMP showstoppers left in rev 2.1.  As far as I can tell they
>are pretty stable under OS X.

There is an SMP showstopper with HW hashtable walk, but Apple
claims to have a HW workaround.

>Linux is probably just missing some deep magic needed for working
>around one or more of the errata that do still apply to rev 2.1.  The
>trouble is figuring out exactly what's wrong... it can be VERY
>difficult to understand all the ramifications of a CPU bug
>(particularly a SMP related bug) until you use a bus analyzer to
>snapshot bus traffic during a crash, or probe CPU registers via JTAG
>after it has crashed, etc.

Especially since you don't have the connector on the motherboard
to put such a tool, and since I don't even have physical access
to any of these machines.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
