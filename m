Subject: Re: "Standard" Practice for config of SanDisk compact pci memory for 405gp
 ppc
To: jwalden@digitalatlantic.com
Cc: linuxppc-embedded@lists.linuxppc.org
From: "Laurent Mohin" <laurent.mohin@acterna.com>
Date: Tue, 24 Dec 2002 08:15:25 +0100
Message-ID: <OF5A07A416.9C613AE7-ONC1256C99.002764D9@eng.eni.wago.de>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Jerry,

I think the easiest way to control a Sandisk compact flash card is in true
IDE mode.
We developed our own custom board based around a 405GP (or 405GPr) chip and
an intel 82371 Southbridge. The southbridge provides 2 IDE interfaces on
which you can attach the Compact flash socket.
You will then find all you need in U-boot to load the kernel and file
system from the compact flash.

Laurent




"Jerry Walden" <jwalden@digitalatlantic.com> on 24/12/2002 02:27:00

Please respond to jwalden@digitalatlantic.com

To:    linuxppc-embedded@lists.linuxppc.org
cc:
Subject:    "Standard" Practice for config of SanDisk compact pci memory
       for 405gp ppc




Our hardware guy is tells me that the SanDisk can be placed
in one of three modes:

1) PC Card Memory Mode
2) PC Card I/O Mode
3) True IDE Mode

The device is going on a custom ppc 405GPr board.

He is also asking me how the device will be accessed

1) on bytes
2) on words
3) or both

I am not much of a hardware person, so I am not even certain if the
question I am asking makes sense.

The main goal is to use u-boot to bootstrap and initialize the board,
and to load the linux kernel/file system from the compact flash.

Does anyone have a reference design for a ppc based SBC with a
san-disc like part on it that runs Linux?

If not, is there a "standard" configuration the the compact flash
is placed on the bus?

Kindest Regards,

Jerry




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
PPCBoot-users mailing list
PPCBoot-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ppcboot-users


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
