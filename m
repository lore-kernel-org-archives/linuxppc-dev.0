Message-ID: <008401c4537a$fb65ba00$2700000a@jmartin>
From: "jmartin" <jmartin@prodys.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: consistent_alloc: cannot access memory
Date: Wed, 16 Jun 2004 10:21:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi again:

    on kernel debug, consistent_alloc memory address returned cannot be
accessed. system have 64 mb ram, high_memory value is c400000 and
consistent_alloc return c500000, but mem addr can't be accessed. System
hangs.

any ideas?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
