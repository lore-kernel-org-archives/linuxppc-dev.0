Message-ID: <3BB8C658.38832E91@mvista.com>
Date: Mon, 01 Oct 2001 15:39:04 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Adam Wozniak <adam.wozniak@comdev.cc>,
	linuxppcdev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: crash in fault.c
References: <3BB8B3AC.3A97D7D@comdev.cc> <20011001193753.838@smtp.adsl.oleane.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> Does the 8260 have BATs ?

Yes.  It's a standard 603e core with BATs and no HPTE.

I suspect this is a hardware configuration problem in the
memory controller or memory interface.  As I have always said,
random problems that occur when the network is used usually
point to that.  The reason is you can get back to back burst
mode transfers to the memory, something you aren't likely
to see with just normal CPU usage.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
