Message-ID: <384133BE.D5DE7F7C@arcormail.de>
Date: Sun, 28 Nov 1999 14:53:05 +0100
From: Michael Fenske <michael.fenske@arcormail.de>
Reply-To: michael.fenske@arcormail.de
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: missing atyfb option in kernel 2.2.14pre9
References: <19991127233137.24145.rocketmail@web1004.mail.yahoo.com> <3840DD4D.E3B73A3E@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:

> It is there. It used to be there twice, once in the list of standard PPC
> video cards, and once in the list of experimental FB drivers. It is now
> classified "experimental", so you see the option only if you choose
> "Prompt for development and/or incomplete code/drivers" in the "General
> setup" menu.

Ah, there is it. Up to now I don't select "Prompt for development and/or
incomplete code/drivers". I think this driver _is_ experimental. For
example scrolling in the console is much slower compared with the offb
driver and what is really annoying is that I can't use atyfb on my
PowerBook G3 (Wallstreet) if I boot it with Open Firmware.

Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
