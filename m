Date: Sun, 9 Nov 2003 12:20:39 +0100
From: Colin Leroy <colin@colino.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: kernel 2.6 : cdc_acm problem
Message-Id: <20031109122039.47e78a91.colin@colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

just to report a problem with kernel 2.6.0-tes9-benh.. Using my GPRS phone
to access internet spits out lots (real lots) of these to syslog:

Nov  8 23:36:21 chloe kernel: Call trace:
Nov  8 23:36:21 chloe kernel:  [c000b604] dump_stack+0x18/0x28
Nov  8 23:36:21 chloe kernel:  [c000885c] check_bug_trap+0x84/0x98
Nov  8 23:36:21 chloe kernel:  [c0008940] ProgramCheckException+0xd0/0x170
Nov  8 23:36:21 chloe kernel:  [c0007ee0] ret_from_except_full+0x0/0x4c
Nov  8 23:36:21 chloe kernel:  [c0021250] local_bh_enable+0x28/0x60
Nov  8 23:36:21 chloe kernel:  [c0109c68] ppp_input+0x204/0x21c
Nov  8 23:36:21 chloe kernel:  [c010e99c] ppp_async_input+0x50c/0x618
Nov  8 23:36:21 chloe kernel:  [c010d890] ppp_asynctty_receive+0x50/0xac
Nov  8 23:36:21 chloe kernel:  [c00d5c7c] flush_to_ldisc+0xa0/0xb0
Nov  8 23:36:21 chloe kernel:  [c00d5d34] tty_flip_buffer_push+0x1c/0x3c
Nov  8 23:36:21 chloe kernel:  [d98fb250] acm_read_bulk+0xdc/0x138
[cdc_acm]
Nov  8 23:36:21 chloe kernel:  [c017e298] usb_hcd_giveback_urb+0x90/0xac
Nov  8 23:36:21 chloe kernel:  [c0187ac8] finish_urb+0xd8/0xec
Nov  8 23:36:21 chloe kernel:  [c0188f28] dl_done_list+0x7c/0x128
Nov  8 23:36:21 chloe kernel:  [c0189a48] ohci_irq+0xec/0x1b4
Nov  8 23:36:21 chloe kernel: Badness in local_bh_enable at
kernel/softirq.c:121

This makes the computer very irresponsive and the log-storm emptied the
battery in about 20 minutes :-)

--
Colin
http://www.colino.net/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
