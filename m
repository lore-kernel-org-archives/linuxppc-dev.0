Message-ID: <3DB6CCA1.3020404@austin.ibm.com>
Date: Wed, 23 Oct 2002 11:21:53 -0500
From: Hollis Blanchard <hollis@austin.ibm.com>
MIME-Version: 1.0
To: Dejan Jovanovic <dejanj@erlangtech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8260 serial on SCC support
References: <20021022193516.CD94710148@denx.denx.de> <006c01c27aac$fda185e0$db00000a@dejanj>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dejan Jovanovic wrote

>
>Now that I boot I get the following output.
>After the 'starting xinetd' is completed sucessfuly, my serial output is stuck.
>However I can telnet to my board.
>This means that there is some problem with the serial? (maybe 'getc' or
>something like this).
>
I suspect you have not enabled a getty on your serial port (see
/etc/inittab). Without that you will not see a login prompt there.

-Hollis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
