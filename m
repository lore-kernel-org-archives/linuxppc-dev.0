Message-ID: <3851A289.226B892C@yahoo.com>
Date: Sat, 11 Dec 1999 09:02:01 +0800
From: Wang Yong <wung_y@yahoo.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: switch mmu context when jump into kernel
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


powerpc 4xx use mmu context(called TID(0~255)) when translate virtual
addr to physical addr. a SPR named PID hold this context, so i think
once i enable the addr translate, i have to set PID to
current->mm->context
to make translating work correctly. and it should be set to 0 when
interrupt or system call arise.
but after studying the kernel source i downloaded from tivo for a long
time, i don't find any code to do that job. i think it mostly should be
in these place: transfer_to_handler and int_return but it not. is the
kernel missing something?

i am sorry if i post this message twice, my netscape got some problem.

Wang


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
