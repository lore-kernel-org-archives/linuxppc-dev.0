Message-ID: <20011025093708.81325.qmail@web20107.mail.yahoo.com>
Date: Thu, 25 Oct 2001 02:37:08 -0700 (PDT)
From: John Francis <johnfrancsis@yahoo.com>
Subject: Is there no vmalloc() for PPC kernel?
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I need to allocate more than page worth of memory in
kernel. Some documentation that I looked at indicated
I should be using vmalloc() , so I tried using it for
PPC kernel and it couldn't find this symbol. Looked
through the code ( 2.4.4 ) and I didn't see it.

What is the best way to allocate "fairly" large memory
pool for use within the kernel by the driver?

John


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
