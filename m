Message-Id: <200110151533.f9FFXSY50083@aslan.scsiguy.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: now random kernel panics with aic7xxx driver 6.2.4 in kernel 2.4.12 
In-Reply-To: Your message of "Mon, 15 Oct 2001 14:24:20 +0200."
             <20011015122420.31143@smtp.adsl.oleane.com>
Date: Mon, 15 Oct 2001 09:33:28 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Today, I recompiled that same kernel, but with different drivers built-in
>(nothing related to SCSI, but that did change the kernel size and boot
>timing), I'm getting a  similar error as above (referenced scb not valid)
>followed by a panic (using the 6.2.1 driver).

Do you know if anything changed in the PCI code that might affect
the initialization of PCI devices?  It is almost as if some of our
PCI register writes are not being honored (e.g. prefetching has
suddenly been enabled for this card even though the prefetch bit
if off in all of its BARs).  6.2.1 has been in the kernel for some
time and was not changed in going from .10 -> .12.

--
Justin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
