Message-ID: <39D388AD.939709DF@mvista.com>
Date: Thu, 28 Sep 2000 11:06:37 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: rshaw@graftononline.net
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using both (the 10Mbps and 100 Mbps) ports on CLLF 860T with Hard
 Hat Linux
References: <002401c0296a$a321fe00$0100000a@nonewr2gx24hxi>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


rshaw@graftononline.net wrote:
>
> I'm using a CLLF 860T with Embedded PowerPC Cross Development Kit Rev. 1.2
> Hard Hat Linux. I'm very new to Linux and developing for a board. Currently,
> I'm booting manually (loading the kernel with tftp) using the 10 Mbps
> ethernet port.

> I had to configure the kernel to use SCC1 so the 10 Mbps line
> is used during the BOOTP requests.

Everything you need to run on a cllf is enabled in the cllf kernel lsp.
I suggest starting from the cllf lsp and then add/change kernel
configuration options as needed.

>
> From the prompt in minicom I can make the cllf board ping my pc and from my
> pc I can ping the cllf board, and this is using the 10 Mbps line. I will
> also need to use the 100 Mbps line except I don't know if its possible to
> use both ethernet ports and how to do it.

of course it is possible.  There are many different ways to do this.  I
am not sure what you need but here is one way.  Simply use the cllf lsp,
which already has both ethernet ports enabled and auto configure with
bootp enabled. Then put the ethernet addresses for both ports in your
dhcpd.conf with different ip's and only one with the root-path option.

> Even if I could find a way to
> switch between these ports, using only one port at a time, I would be happy.
> Surely this is possible because the 10 Mbps port and 100 Mbps port have
> different MAC addresses.

you can do this as well.  just enable the port you want in the kernel
configuration and disable the one you do not want.


Matthew Locke
Montavista Software

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
