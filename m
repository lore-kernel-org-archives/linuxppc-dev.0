Message-ID: <3A22B028.6182249F@fnc.fujitsu.com>
Date: Mon, 27 Nov 2000 13:04:08 -0600
From: Konstantin Sabodash <konstantin.sabodash@fnc.fujitsu.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org, wg@world.std.com
Subject: Memory map
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello TWG - pat, mark & steve.

I've seen your post to linuxppc-embedded@lists.linuxppc.org  regarding
memory access  from Linux.
Your code works fine.

 "paddr2 = mmap(0,size,PROT_READ|PROT_WRITE,MAP_SHARED,fd,0x50000000);"

But  page size is 1K and their start addresses  appears in address
space  with increment 0x1000.
So if I put 0x50000400 address it give me segmentation fault. It works
fine in region 0x50000000 ...  0x500003ff  next 0x50001000 ...
0x500103ff and so on.
Question : how can we increase page size to eliminate these holes.
Thanks in advance.

--
Konstantin Sabodash


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
