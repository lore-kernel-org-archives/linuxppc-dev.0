Message-Id: <sc21a438.048@mail.pel.dk>
Date: Thu, 20 Dec 2001 08:41:08 +0100
From: "Jakob Jepsen" <JSJ@voxtream.com>
To: "<" <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8xx INIT_TASK_SIZE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

Why is it not possibly to increse INIT_TASK_SIZE in schred.c and there by increse the kernel stack size?

Im running a heavy loaded RTLinux subsystem and the hole system (2.4.4 from Denx) go's down when i start a big probram in Linux user-space.

Regards
Jakob Sloth Jepsen


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
