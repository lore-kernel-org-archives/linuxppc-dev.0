From: Kwanksuk Kim <kskim@neowave.co.kr>
To: "Ron Bianco" <ronb@junction.net>, "Ian Abbott" <abbotti@mev.co.uk>
Subject: add-symbole-file doesn't work properly in powerpc-linux-gdb 
Date: Thu, 1 Feb 2001 11:15:30 +0900
Content-Type: text/plain
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <000501c08bdf$df460610$4d012ac7@warp-speed>
In-Reply-To: <000501c08bdf$df460610$4d012ac7@warp-speed>
MIME-Version: 1.0
Message-Id: <01020111314103.00751@kskim.neowave.co.kr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using HHL developement kit.

I used command 'add-symbole-file' for module debugging, but It doesn't work
properly...

I loaded the object file, and typed 'list <function>' command
The module has 10 functions included in one source file, but I can only access 4
of them form start line.

When I typed 'list' command for 'device_release', this message displayed.

No line number known for device_release.

Maybe it seems that only some portion of symbols are loaded.

Why aren't whole symbols loaded?

This happened using gdb 5.0 for powerpc cross debugging, but never happened
using i386 debugging for the same source.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
