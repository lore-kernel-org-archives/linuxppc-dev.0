Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20030116044911.1234.qmail@web41201.mail.yahoo.com>
Date: Wed, 15 Jan 2003 20:49:11 -0800 (PST)
From: Prakash kanthi <pkanthi@yahoo.com>
Subject: Ramdisk details; execve("/bin/sh") output
To: Frederic Soulier <soulier@aztec-radiomedia.com>
Cc: "PPC-Linux list (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <014101c2bc70$dc57b610$9900010a@aztec.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi FOlks,

I have couple of questions on ramdisk operation.

1. How can i see the contents of a ramdisk? I
downloaded one from denx and i want to see what is in
there?
2. In ${LINUX_ROOT}/init/main.c -> init(), after
prepare_namespace (which basically does the inintrd
mount), open syscall on '/dev/console' fails. But
still control goes further and executes
'execve("/bin/sh")'. My question is where does the
output of /bin/sh execution goes? Not to my dumb
terminal? I see nothing. Infact my dumb terminal just
stops there. No kernel panic. Any clues?

Note: In my case i do not have enough infrastructure
to have the  standard NS16550 is working. So i have to
port some other driver as my serial driver. ANything
related to this?


Thanks,
Prakash


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
