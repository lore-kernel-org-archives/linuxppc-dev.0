Date: Tue, 17 Apr 2001 14:25:33 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Eddy Raineri <eraineri@axiom-tx.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Quad SMP on G4
In-Reply-To: <20010416170158.17749@smtp.wanadoo.fr>
Message-ID: <Pine.HPX.4.10.10104171421420.11443-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 16 Apr 2001, Benjamin Herrenschmidt wrote:

> Also, do you have the kernel BAT mapped or did you remove that optim ?
> I'm not too sure the hash table code is very safe to run without this.
> I beleive that without the BAT mapping, the code & data that are
> touched when the hash table lock is held should be locked in the TLB as
> well to avoid deadlocks.

How do you lock something in the _TLB_ ?

Avoiding the removal/overwrite of some critical hashtable entries is fine,
but you can't prevent any TLB entry from being purged by replacement HW.

	Gabriel.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
