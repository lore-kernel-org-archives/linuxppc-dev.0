From: Benjamin Herrenschmidt <bh40@calva.net>
To: Iain Sandoe <iain@sandoe.co.uk>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pdisk & G4
Date: Thu, 6 Jul 2000 14:36:42 +0200
Message-Id: <20000706123642.22511@mailhost.mipsys.com>
In-Reply-To: <200007061057.LAA27826@hyperion.valhalla.net>
References: <200007061057.LAA27826@hyperion.valhalla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>pdisk 0.7a4 (MacOS version) does not appear to run successfully on
>G4/sawtooth (that is, it runs without crashing but reports no devices -
>every ATA device shows as 'not ready').
>
>This is the latest version on LinuxPPC 2000 and a quick check of the Apple
>Developer site did not reveal a newer version.  It's an Apple program.
>
>Does someone have the sources - or is there an alternative (OK - I will use
>the new Apple Disk Setup  which gets me most of the way - but pdisk is jolly
>useful for checking that everything is OK).

The MacOS version of pdisk is bogus. The recommended practice is to:

 - Use Drive Setup to create the MacOS partitions, leave empty space for
Linux partitions
 - Boot the Linux installer
 - Use pdisk from the linux installer to create the Linux partitions
 - Reboot the installer (may not be needed in all cases, but I prefer
this way)
 - Complete install

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
