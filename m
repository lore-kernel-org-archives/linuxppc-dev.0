Message-Id: <200104171403.QAA00755@piglet.grunz.lu>
Date: Tue, 17 Apr 2001 16:03:45 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: boot params
To: iain@sandoe.co.uk
Cc: erbenson@alaska.net, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010417093736.4BEC72F001@apollo.valhalla.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  17 Apr, this message from Iain Sandoe echoed through cyberspace:
>
>> everyone i know running quik doesn't have any problems.
>
> That may be true with quik itself - but console usage of OF is a PITA for
> most of the older (OF 1.0.5-ish) machines - I can't get my 9600 to retain
> the re-mapping of kbd/screen for more than one reboot - i.e. set the OF vars
> (using BootVars) reboot - OF is OK to screen & kbd.   Next reboot they are
> reset back to point to 38400 serial :-((( ...

You sure your backup battery is OK? It's not completely dead, I think
otherwise the box wouldn't boot; but you may test it anyhow.

Also, you could add an nvsetenv script on shutdown as a workaround.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
