Date: Wed, 03 Jan 2001 23:25:48 +0100
Subject: Changes in the Valkyrie driver from 2.1.24 to 2.2.18
From: Chris Boot <bootc@worldnet.fr>
To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B6796554.7E88%bootc@worldnet.fr>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

It has struck me, after weeks of research, that my problems in booting my
5400/180 cold through OpenFirmware are caused by changes in the Linux
kernel.  This machine uses the Valkyrie display device, and in 2.1.24 this
is handled by directly accessing its memory, whereas in 2.2.18 it is
accessed through OpenFirmware.  OpenFirmware is known to choke on this
machine when using the display (as in CLAIM failed).

My suspicions were aroused when, after disabling CONFIG_FB, the machine
booted cold without any problems whatsoever.

Is it at all possible to use Valkyrie without going through OpenFirmware at
all?  It is not selectable if I disable CONFIG_FB_OF.  Would it be possible
to port the older non-OF driver to the newer kernel?  What are the
disadvantages of using the older memory-based driver to the newer OF-based
driver?

Thanks.

--
    .-.        Chris Boot
    /v\     bootc@worldnet.fr
   // \\
  /(   )\   L   I   N   U   X
   ^^-^^   >Phear the Penguin<


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
