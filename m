In-Reply-To: <Pine.LNX.4.10.9911120738300.4566-100000@shell.unixbox.com>
Date: Fri, 12 Nov 1999 17:20:03 +0100
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: 2.3.27 on CHRP Longtrail
Message-Id: <19991112172003.001697@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Not directly related, but...

While working on OF booting with the iBook (I really want to get rid of
BootX with those new machines, on of the reason beeing a nightmare
compatibiliy problem with the new iMac DV and Swathoo G4s), I quickly
hacked my early boot text mode to work with the OF display.

Basically, that means that it's possible to display debugging text from
almost every point of the kernel initialisation (using mostly
xmon_printf) before the fb is up and running, even while OF output can no
more be used (after MMU init).

It's too hackish for now, and I have no time to post a patch before later
today or this week end, I'll try to clean this a little bit and separate
it from the main bunch of iBook patches since i could be useful for
others too.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
