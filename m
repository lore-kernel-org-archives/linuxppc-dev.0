From: linas@austin.ibm.com
Date: Wed, 9 Jul 2003 10:22:20 -0500
To: Tim Seufert <tas@mindspring.com>
Cc: Stefan Jeglinski <jeglin@4pi.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: OT: wanting to write PCI daemon
Message-ID: <20030709102220.A40374@forte.austin.ibm.com>
References: <p06001800bb30f2ae6091@[192.168.0.254]> <DAD09CD5-B1C0-11D7-8101-003065F22EAA@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DAD09CD5-B1C0-11D7-8101-003065F22EAA@mindspring.com>; from tas@mindspring.com on Tue, Jul 08, 2003 at 08:53:09PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 08, 2003 at 08:53:09PM -0700, Tim Seufert wrote:
>
> On Tuesday, July 8, 2003, at 03:46  PM, Stefan Jeglinski wrote:
> > We then just need a)
> > to talk TCP/IP out the one end, and b) PCI on the other.

??
tcpip has the concept of sockets and ports.  Maybe you mean 'udp'?
Do you need to forward *all* internet traffic, or just some of it?
Not everything on an ethernet cable is tcpip; there's a whole zoo
of protocols that one typically sees on a LAN.

> (Though I'm not sure whether it would be a good idea to use an existing
> daemon as anything beyond sample code to see how real live TCP/IP
> communications work.

Agreed.  The standard unix programming interfaces are not that hard.
You can write a simple daemon yourself with a few dozen lines of code.
(and less if you're clever).  After that, its all custom, app-specific
code.   I think you need a good book w/ examples in it.


--linas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
