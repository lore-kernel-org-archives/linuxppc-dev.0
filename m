Message-ID: <762A181C0D966E459A2EB3B810142C7703861203@nmrusdunsx12.nmrlan.net>
From: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: "'zjzhou@newrocktech.com'" <zjzhou@newrocktech.com>
Subject: RE: reboot by software
Date: Tue, 16 Dec 2003 09:40:08 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Now, I want to reboot system by software. But, when I jump to 0xfff00100
in kernel mode, it's going > dead. Can anybody help me?

If you have the Software Watchdog Timer enabled, just do a lock-interrupts
followed by a branch-self.

Charlie


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
