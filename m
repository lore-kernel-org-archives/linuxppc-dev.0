Date: Tue, 17 Apr 2001 10:13:12 +0100
Subject: Re: boot params
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Ethan Benson <erbenson@alaska.net>,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010417093736.4BEC72F001@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Mon, Apr 16, 2001 at 08:11:21PM +0200, Giuliano Pochini wrote:
>>
>> Not a good choice. Often it happens you can't type anything in the
>> OF boot menu script, so you can't choose what OS start up (or at
>> least my 7300 with OF v1.0.5 had this problem). It also happens on
>> a 2nd-half-2000-series G4 where the ofboot script refuse to accept
>> keyboard input 80% of the times.
>
> everyone i know running quik doesn't have any problems.

That may be true with quik itself - but console usage of OF is a PITA for
most of the older (OF 1.0.5-ish) machines - I can't get my 9600 to retain
the re-mapping of kbd/screen for more than one reboot - i.e. set the OF vars
(using BootVars) reboot - OF is OK to screen & kbd.   Next reboot they are
reset back to point to 38400 serial :-((( ...

BootX is much nicer... :-)  especially for those of us who still _need_ to
use MacOS for other work...

ciao,
Iian.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
