Date: Tue, 20 Apr 2004 18:48:24 +0200 (CEST)
From: Marius Groeger <mgroeger@sysgo.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: atyfb Framebuffer driver
Message-ID: <Pine.LNX.4.56.0404201842490.20260@mag.sysgo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

does anyone know about the state of the atyfb_base.c driver in 2.4.25
on kernel.org? I'm trying to use it on a Keenya (Tanzania 4400 Board)
but it seems to generate strange sync signals my TFT display can't
catch. Tried almost all video=atyfb:vmode:.. configurations to no
avail. BTW, the OFFB driver doesn't seem to work either.

Any clue from the masters? Any hints appreciated!

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.com>           Project Manager
SYSGO AG                      Embedded and Real-Time Software
Voice: +49 6136 9948 0                  FAX: +49 6136 9948 10
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
