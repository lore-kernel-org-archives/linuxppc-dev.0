Message-ID: <3A22C5BF.445BF4F1@mvista.com>
Date: Mon, 27 Nov 2000 13:36:15 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Dan Jankins <DJankins@communica.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MP8240 UART
References: <NEBBKDMDALNLPJILFLLOCEBFCAAA.DJankins@communica.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Jankins wrote:

> Hi All,  I am a new to PowerPC.  I have downloaded the Sandpoint Doc?s
> including Schematic.  I the Unity X4 schematic  (page 9) has reference to a
> UART (SOUT1, SIN1, RTS1, CTS1) but the MP8240 Data sheet status these line
> are PCI clock.
>
> Is there a UART in the MP8240?  If so where can I find information on it.
> Also does Hardhat Linux use this port?

There is no uart in the 8240 itself or on the 8240 processor module but there
is a uart on the sandpoint.  It is a 16550 compatible uart on the National
87308VUL SuperIO chip.  Go the the National website for more info on that
chip.

Yes, Hardhat linux supports that hardware.  That is what the serial console
uses.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
