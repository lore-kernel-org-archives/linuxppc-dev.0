Reply-To: <tschaefer@giga-stream.de>
From: =?iso-8859-1?Q?Thomas_Sch=E4fer?= <tschaefer@giga-stream.de>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Boot problems with MPC8280 PowerQUICC
Date: Mon, 13 Oct 2003 19:35:47 +0200
Message-ID: <FIEJJAKAABLMHFKFECNJOEKIGPAA.tschaefer@giga-stream.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm working on a custom board with Motorola MPC 8280 PowerQUICC processor
and linux 2.4.18 kernel. When booting the kernel, I get the following
messages at the end of the boot procedure when init scripts are executed:

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.10.11.190
Looking up port of RPC 100005/1 on 192.10.11.190
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 60k init
INIT: version 2.78 booting
INIT: Entering runlevel: 2
Inconsistency detected by ld.so: dynamic-link.h: 62: elf_get_dynamic_info:
Assertion `! "bad dynamic tag"' failed!
INIT: Id "con" respawning too fast: disabled for 5 minutes
INIT: no more processes left in this runlevel
INIT: Id "con" respawning too fast: disabled for 5 minutes
INIT: Id "con" respawning too fast: disabled for 5 minutes

The kernel did not crash, ping is working and the last message is repeated
every 5 minutes. It seems that all processes started by the INIT process are
killed immediately.
Booting the same kernel with the same root fs mounted over nfs on the same
board but with a MPC8266 PowerQUICC is working without problems.
Anybody who faced a similar problem? Any hints would be appreciated.

Best regards,

Thomas Schäfer

____________________________________

GIGA STREAM GmbH

Konrad-Zuse-Str. 7
66115 Saarbrücken

Tel.: + 49 (0)681 / 95916 - 203
Fax:  + 49 (0)681 / 95916 - 100
E-mail: tschaefer@giga-stream.de


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
