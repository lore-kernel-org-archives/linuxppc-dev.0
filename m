Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Linux on MPC5200 - LITE5200EVAL
From: Gerrit Van de Velde <gvd@denayer.wenk.be>
To: Andrew Dennison <andrew.dennison@motec.com.au>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <002301c3f05a$4f971490$4000a8c0@ANDREWDT3>
References: <002301c3f05a$4f971490$4000a8c0@ANDREWDT3>
Content-Type: text/plain
Message-Id: <1076491141.4841.6.camel@nios>
Mime-Version: 1.0
Date: 11 Feb 2004 10:19:01 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


<snip>

> #dBUG commands to load u-boot via tftp
> set mac 00:01:AF:52:01:xx # see MPC5200LITE doco for how to choose xx value
> set client lite.ip.address
> set server tftpserver.ip.address
> set netmask your.netmask
> dn -i -o 0x100000 /tftpboot/u-boot.bin
> fe 0xff000000 0xff050000
> fp 0xff000000 0xff040000 0x100000
> #power off and change link to boot low
> #power up to u-boot
>

I followed these instructions and it all worked out fine (left out the
examples directory of U boot though) , but after the reboot in lowboot
jumper configuration, i only see garbage on my minicom screen. I can
figure out some characters that look familiar (like the countdown for
the autostart) so I assume it's working correctly but doesn't get
displayed right. I also can't interrupt the countdown so input doesn't
work. Already tried to change the 115200 8N1 settings of the
communications (but why would they change anyway..) and didn't help.

What could possibly be wrong ??

> read u-boot wiki to do it differently:)
>
> NOTE: if you have a Version 2.0 board and want 16MiB flash to actually work
> you should ensure J24 is in the 2-3 position (J24 is a 0R resistor on the
> bottom of the board).
> It is stupid for the jumper to be in the 1-3 position when 16MiB is loaded
> but that is the way my board was. Seems like a manufacturing error:(
>

checked it and there's a resistor between 2-3 and not 1-3 so i guess
that's right.. (I have version 2.0 Lite)

> Andrew

Regards,
Gerrit


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
