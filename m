From: "dong in kang" <dkang@east.isi.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Does Linux kernel use paging or BAT registers before running the first user-level program "/bin/sh"?
Date: Fri, 8 Aug 2003 10:09:25 -0400
Message-ID: <002601c35db6$acc8aed0$6601a8c0@Minjoo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20030807213228.A9194C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Does Linux kernel use paging or BAT registers before executing "/bin/sh"?
How can I test if paging works fine?

  My Linux kernel crashes while it accesses page table entry for argument
page which is called
   load_elf_binary --> setup_arg_pages --> put_dirty_page.
The address of page table entry is 0xb0beffc which is not a valid address.
When the kernel accesses that address, it crashes.
I suspect that paging may not work properly.

Did anybody have this problem?

 Dong-In


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
