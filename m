Message-Id: <200007070652.HAA20893@hyperion.valhalla.net>
Date: Fri, 07 Jul 2000 07:52:10 +0100
Subject: Re: Multi-boot advice.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
CC: Ethan Benson <erbenson@alaska.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 7, 2000 Ethan Benson wrote:
> On Thu, Jul 06, 2000 at 09:38:38AM +0100, Iain Sandoe wrote:
>> Yea Hey first to Apple Drive setup (which at least these days will allow
>> most stuff to be set up) - and then to pdisk - to check it out.
>
> just don't create any linux partitions with apples drive setup, it
> won't work.  instead add up the sizes of all the planned linux
> parittions and create a placeholder HFS partition with apple drive
> setup, then delete it with pdisk and populate the freed space with the
> linux and bootstrap partitions.

This is interesting.  I've seen (several times) the comment that the Apple
Drive Setup tool doesn't work for Linux.

However, it certainly did for me (on the Lombard & on a 9600/233)... under
what circumstances does it fail?

Still hacking sound stuff on the G3 at present...
haven't got round to following all the advice on set up of the G4 (thanks to
all contributors)...  should be a breeze :-)

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
