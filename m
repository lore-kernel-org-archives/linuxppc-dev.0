Message-ID: <3E6CB100.60402@embeddededge.com>
Date: Mon, 10 Mar 2003 10:36:32 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Wojciech Kromer <krom@dgt-lab.com.pl>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8250 pci
References: <3E6C667F.4070304@dgt-lab.com.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wojciech Kromer wrote:

> I'm looking for 8250 pci code for 2.4.19 linux (or any other).
>
> Is code for 8240 applicable ?

Well, er, um, it depends :-)

The 8250 has a custom, lightweight, PCI interface, while the 8240
uses the standard mpc-10x controller.  The lower level initialization
and PCI access functions won't work, but you can use the framework
to get started.  The mpc-10x also implies the EPIC, so disregard
all references to that.  You could also look at some of the other
PCI interfaces, like the QSpan, for examples.

Good luck.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
