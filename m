Date: Tue, 17 Apr 2001 15:55:40 +0100
Subject: Re: boot params
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010417145530.189392F008@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 17, 2001, Ethan Benson wrote:
> On Tue, Apr 17, 2001 at 04:03:45PM +0200, Michel Lanners wrote:
>>
>> You sure your backup battery is OK? It's not completely dead, I think
>> otherwise the box wouldn't boot; but you may test it anyhow.
>>
>> Also, you could add an nvsetenv script on shutdown as a workaround.
>
> well on some machines the MacOSROM resets the nvram, so you must never
> allow it to boot.

I think this is the case with 9600 - it's always behaved this way and I've
no (other) reason to be suspicious of the battery (you usually get a warning
in that several power button presses are required to start it).

Anyway all my machines power are on & active 24/7 - even those running MacOS
;-?

One day I might try to figure out something that will work - because it _is_
possible to change the vars using BootVars and get one 'reboot' into OF
screen/kbd with the new params.

Iain

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
