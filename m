Message-ID: <20030122022104.94934.qmail@web41506.mail.yahoo.com>
Date: Tue, 21 Jan 2003 18:21:04 -0800 (PST)
From: b y <by012345@yahoo.com>
Subject: CONFIG_SERIAL_TEXT_DEBUG works ?
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Anybody knows if CONFIG_SERIAL_TEXT_DEBUG and its
associated code sandpoint_progress() worked or not ?
It seems that it will cause an exception if I turn it
on. My board had UART base address at 0x7c03_0000.

Thanks.

Bo


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
