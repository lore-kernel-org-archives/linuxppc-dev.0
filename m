Date: Sat, 05 Apr 2003 17:35:25 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: check MMU state
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Reply-To: tglx@linutronix.de
Message-id: <200304051735.25831.tglx@linutronix.de>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

Is there a clean way to check, if the MMU is enabled on kernel entry ? I have
to port Linux to a PMC-module, where the bootloader code should not be
changed.

--
Thomas
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
