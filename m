Message-ID: <20010807123341.19790.qmail@web14509.mail.yahoo.com>
Date: Tue, 7 Aug 2001 05:33:41 -0700 (PDT)
From: ambarish <ambarishak@yahoo.com>
Subject: Kernel Hangs !
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hai Everybody,

I have been trying to port linux 2.2.14 on custom made
board,
the processor is mpc823.

The problem is after printing the following message,

Freeing unused kernel memory: 52k init

it hangs. after putting some debugs, I used show_mem
function from
init.c the following output comes.


Mem-info:
Free pages:       30792kB
 ( Free: 7698 (64 128 192)
NonDMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB
0*256kB 0*512kB 0*1024kB 0*204)
DMA: 0*4kB 1*8kB 2*16kB 1*32kB 0*64kB 0*128kB 0*256kB
0*512kB 0*1024kB 15*2048k)
Swap cache: add 0, delete 0, find 0/0
Free swap:            0kB
8192 pages of RAM
7812 free pages
315 reserved pages
0 pages shared
0 pages swap cached
0 pages in page table cache
Buffer memory:          4kB
Buffer heads:        20
Buffer blocks:        4
Buffer hashed:        0
Networking buffers in use          : 1
Total network buffer allocations   : 20
Total failed network buffer allocs : 0
IP fragment buffer size            : 0
Process  Pid Cnt      Ctx   Ctx<<4 Last Sys        pc
   task
swapper    1   1        1       16       11 ?00000000
c0176000
kupdate    2   1        2       32       -1 ?00000000
c010c000
rpciod     3   1        0        0       -1 ?00000000
c018e000

my question is why address is showing as zero for the
process. How can I solve this problem.
Can any body help me to solve my problem

Thanks in advance for the suggestion.

Thanks
Ambarish.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
