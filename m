Message-ID: <39C24395.756E3252@mvista.com>
Date: Fri, 15 Sep 2000 11:43:17 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Rainer Kloud <rainer.kloud@siemens.at>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8260 FCC Ethernet driver
References: <39C1DE70.F1D90668@siemens.at>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rainer Kloud wrote:

> So my question is: Does anyone have a Ethernet Driver
> for the FCC?


Ummmm.....arch/ppc/8260_io/fcc_enet.c should do the trick......

I am constantly making updates to the sources for 8260, and recently
updated the driver (there is another major update coming).  You should
probably get used to using the BitKeeper tree from FSM Labs...
	www.fsmlabs.com/linuxppcbk/html


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
