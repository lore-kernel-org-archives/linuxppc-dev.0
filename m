Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <937610FE9B70D511B3E700508B8B65770E53FC@MAIL1>
From: Shie Erlich <shie_e@elbit.co.il>
To: "Linuxppc-Embedded mailing list (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: problem inserting modules
Date: Sun, 6 Jan 2002 11:05:39 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="WINDOWS-1255"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,
i have a modified kernel running on a custom board. the kernel runs fine,
however, when
attempting to insmod a simple module (a hello world module), i get:

can't allocate kernel memory: 400 bytes needed.

i thought that the message is comming from sys_create_module(), however, it
seems like
it doesn't, as none of my printk()s and panic()s show up. the module is
compiled properly
and with the correct kernel headers. i did change the memory mapping
(mm/init.c), could
it be related ?

		thanks,
			Shie Erlich


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
