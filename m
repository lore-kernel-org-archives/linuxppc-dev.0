Date: Sun, 19 Aug 2001 01:26:45 +0100
Subject: Re: Mace and Bmac ethernet drivers [was: Occasional crash reports]
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Mike Fedyk <mfedyk@matchmail.com>,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010819002647.48C57DBAFB@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Aug 18, 2001,  Mike Fedyk wrote:
> On Sat, Aug 18, 2001 at 12:16:58PM +0100, Iain Sandoe wrote:
>> as I say, booting with the BootX *init* (rather than the application) bmac,
>> at least, seems reliable on g3/beige (don't use Mace much).

> What's your best uptime for the g3?  I have one setup as a ipsec
> gateway/firewall, and it didn't last over 28 days.  Add a tulip card (it
> already had one for firewall, now has two...) and I now have 70 days uptime.

Hmmm.  The g3/beige is my dev box - the interval between reboots for new
kernels is much less than that ;-)

I don't (necessarily) think this is the same problem - with the corruption I
was seeing  booting using the BootX *app* I was struggling to get 2 hours
uptime ... it was crashing with illegal instruction oopses in the network
stack.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
