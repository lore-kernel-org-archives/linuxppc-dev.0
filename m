Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <sc21a5bd.052@mail.pel.dk>
Date: Thu, 20 Dec 2001 08:47:50 +0100
From: "Jakob Jepsen" <JSJ@voxtream.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8xx INIT_TASK_SIZE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

Why is it not possibly to increase INIT_TASK_SIZE in schred.c and there by increase the kernel stack size?

Im running a heavy loaded RTLinux subsystem and the hole system (2.4.4 from Denx) go's down when I start a big program in Linux user-space.

Regards
Jakob Sloth Jepsen


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
