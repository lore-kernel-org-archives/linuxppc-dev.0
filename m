Date: Sat, 22 Apr 2000 15:40:11 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Bernhard Reiter <bernhard@intevation.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Serial driver problem (modem Lombard)
In-Reply-To: <20000422123747.B8503@cheops.usf.Uni-Osnabrueck.DE>
Message-ID: <Pine.LNX.4.10.10004221538430.29093-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Running wvdialconf it started scanning ttyS1 and
> then jumped into the system monitor:
>
> vector:200 at pc=d0849344 msr=1030, sp=c7bf3ce0 [c7bf3ce0]
> current=c7bf2000, pid 745 comm=insmod

Looks like it happens when inserting a module. Can you try to compile in
the serial driver, instead of building it as a module?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
