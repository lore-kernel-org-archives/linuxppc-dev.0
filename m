Message-ID: <3B6BB018.6070900@humboldt.co.uk>
Date: Sat, 04 Aug 2001 09:19:36 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: Ron Bianco <ronb@junction.net>
Cc: bhupinder sahran <bhup_sah@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 21554 device driver
References: <000301c11c78$80e43fe0$4d012ac7@warp-speed>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ron Bianco wrote:
> However, the 8240 is able to handle up to 5 pci devices on it's own and has an internal arbiter.
> 66Mhz PCI too in some configurations.
> Therefore I'm curious about the fact that you apparently want to interface to more than 5 PCI devices.
> Is this correct?  Seems extreme for an embedded system.


As mentioned in the original post, the 21554 is a non-transparent PCI
bridge. This is normally used to make a device such as an 8240 into a
peripheral of a workstation or server.

In answer to the original question on drivers for the 21554, such code
is generally application dependent. I've been thinking of writing a
general framework for non-transparent bridging, but at the moment
nothing exists. So the first thing you need to do is decide on the
protocol between the applications on each side of the bridge. If the
protocol is IP, then there's code you'll be able to use as a starting
point, such as Montavista's Hard Hat Net:

http://www.mvista.com/products/hardhat.html

--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
