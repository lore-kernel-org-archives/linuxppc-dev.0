From: kd@flaga.is
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <00256797.004D1A24.00@notes.flaga.is>
Date: Mon, 21 Jun 1999 14:02:09 +0000
Subject: MPC8xx Interrupt vectors
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

Two problems:

1) When I make an application do a page_fault (segmentation fault) the
kernel crasses insted of just the application crassing.
Needless to say I do not have an secondary storage or an swap device, but I
am running rootfs from /dev/nfs. System has
only 4MB of ram.
2)When the system crasses it goes into the "Rebootting in 180 s" prompt,
but fails to reboot, i.e. it goes into endless loop, like:
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..<0>Kernel panic: Kernel Mode Software FPU
Emulation
Rebooting in 180 seconds..

In the reset vector there are probably some corrupted data that looks like
FPU instuction that triggers the FPU trap.

This makes me think that the Interrupt vectors are somehow screwed.

Do you guys recognise this behaviour?

System is embedded 2.2.5 with mpc 823 CPU  4MB of Ram.

Thanks,

K.D.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
