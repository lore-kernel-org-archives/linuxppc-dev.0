Date: Sat, 18 Aug 2001 12:16:58 +0100
Subject: Re: Occasional crash reports
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Robert E Brose II <bob@kunk.jriver.com>,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010818111705.1E2B2DB9D0@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Aug 18, 2001, Robert E Brose II wrote:
> On Mon, Aug 13, 2001 at 09:59:05PM -0500, Takashi Oe wrote:
>> I don't really know, but I can confirm that both 2.2.x and 2.4.x kernels
>> are unstable on a beige g3 and a bmac equipped b/w g3.  I can crash them
>> rather easily with regular programs, given a day or two.  I have not seen
>> similar instability on other machines (dual g4, 7600, all nubus).
>> Unfortunately, I don't have any time to track it down right now  :(
>
> I've been able to trace that to the mace and bmac ethernet drivers, which
> are *very* unreliable in 2.2.  Get the latest drivers from Donald Becker for
> tulip, rtl8139, eepro100, etc. and you're set.  I haven't tried 2.4 yet.

apropos bmac - is there a dbdma problem?
I think Takashi did a dbdma fix ... did that go in?

> -- end of forwarded message --
>
> Mace is still unreliable in 2.4. It's always been just plain unreliable
> for me on 7200, 7500 and 7600's.

 - are these clones or Apple originals?
we found other dbdma problems on clone 7x00 machines for PowerComputing (in
the sound side) ...

might be worth checking that there are no cases of "DEAD" status coming up
on the Mace driver...

as I say, booting with the BootX *init* (rather than the application) bmac,
at least, seems reliable on g3/beige (don't use Mace much).

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
