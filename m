Message-Id: <200101042057.PAA38658@mal-ach.watson.ibm.com>
To: Tibor Pausz <pausz@stud.uni-frankfurt.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Status of PCI-PCI bridge on UMAX S900 
In-Reply-To: Message from Benjamin Herrenschmidt <bh40@calva.net>
   of "Thu, 04 Jan 2001 21:41:04 +0100." <19341129141248.27470@mailhost.mipsys.com>
Date: Thu, 04 Jan 2001 15:57:12 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Benjamin Herrenschmidt writes:

Ben> The "interrupts" property can have various meanings depending on the OF
Ben> version, I suggest you don't mess with it. Just check that if you find no
Ben> AAPL,interrupts, and that pmac_newworld == 0, then look for parent
Ben> AAPL,interrupts.

	"interrupts" property is well-defined in the OF spec for each
device-tree node, but I do not think that prom.c currently has enough
parsing ability to handle the complexity or makes too many assumption.
And it does not need to fully parse that property, as Ben suggests.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
