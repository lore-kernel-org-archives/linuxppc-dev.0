Message-ID: <819E3E914E0AD11194DE00805F0D100B0138B829@fbi.infocom.dk>
From: Kim Jørgensen <KIJ@infocom.dk>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: No bash prompt 
Date: Wed, 12 Apr 2000 15:54:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>> Hi.
>>
>> A got a similar problem as described by LiuTao, my custom MPC823 board
won't
>> display the bash prompt at start up. Is there anybody who got a solution
to
>> this problem?
>
>Do you get any console output  at  all?  Try  instrument  init/main.c
>round the exec of the standalone shell / init program.

No after "Freeing unused kernel memory: 24k init", nothing appears on the
console.
I tried to put a printk before execve("/bin/sh"... and one after. Only
output from the first printk appears on the console.

>Do you see any output in the log_buf area?

What is the log_buf area?

>> I have successfully used the ramdisk image on a RPXL board, so that
should
>> be ok.
>
>What  happens  without  intrd,  for  instance  woith  NFS   as   root
>filesystem?

I haven't got Ethernet on my board.

>You seem to have 8 MB of RAM; how big is your (uncompressed) initrd?

The uncompressed ramdisk image is 1.5MB.
I tried to program my flash with the kernel and ramdisk, and boot without
the debugger, but it still didn't work.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
