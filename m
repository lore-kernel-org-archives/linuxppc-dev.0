Reply-To: <jwalden@digitalatlantic.com>
From: "Jerry Walden" <jwalden@digitalatlantic.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: "Standard" Practice for config of SanDisk compact pci memory for 405gp ppc
Date: Mon, 23 Dec 2002 17:27:00 -0800
Message-ID: <EGEGIJHKDKJGAJMGIDPNAEBOCDAA.jwalden@digitalatlantic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
