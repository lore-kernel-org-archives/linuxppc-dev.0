From: xiaogeng_jin@agilent.com
Message-ID: <9153F74610B7D311B83900902771C871124D938B@axcs07.cos.agilent.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Halt command
Date: Mon, 27 Jan 2003 12:41:33 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


How can a HALT command just halt the system not to reboot the system? My system is a MPC8xx custom board and I'm using Busybox.

I checked the source code of HALT command in busybox. And it just sends a SIGUSR1 to init but behaves just like REBOOT which sends a SIGTERM to init. Thanks in advance for your thoughts.

- shawn.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
