Message-Id: <387461B6.FDB5DB5C@ict.ac.cn>
Date: Thu, 06 Jan 2000 17:34:46 +0800
From: LiuTao <tliu@ict.ac.cn>
Mime-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: the problem of booting kernel
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all:

I am porting Linux to a board which has MPC860MH50, 16M RAM and 2M
Flash.
I am using visionPROBE(emulator of EST) to debug my program.
I download the zImage to the board by emulator, then run it.
I can see the following:

loaded at:     00800000 0080B1C8
board data at: 00800158 00800180
relocated to:  007F0100 007F0128
zimage at:     00830263 0088A2B1
avail ram:     0088B000 01000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel

Now, I find that the program stoped at 0x111C.

So I set a breakpoint at "blr" in head.S at which the program will jump
to the kernel. I ran the program again, it stoped at the breakpoint.
Then I ran it step by step, I found that it jumped to 0x0000000C, I
think
that's the correct address. Then, I ran it continuously, it stopped at
0x111C again.

That's very strange. If I don't set breakpoint at "blr" but set a
breakpoint
at 0x000C, the program can't stop at the breakpoint but stop at 0x111C.
If I
set breakpoint at "blr" and run it step by step, the program can get
0x000C.

Do you have any suggestions?
Thanks!

LiuTao

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
