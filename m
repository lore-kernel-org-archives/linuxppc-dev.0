Message-ID: <3E674B38.1BB1C51D@cdotd.ernet.in>
Date: Thu, 06 Mar 2003 06:20:56 -0700
From: Rahul Dev <rahuld@cdotd.ernet.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: bat programming
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

     I   am porting  linux2.5 over  ads 8120 board.
     I  load the kernel (vmlinux) at memory location 0x00  through
debugger(visionclick).

     My  KERNELBASE=0xc0000000 and the  ram on my board is 16MB.

     I am having some doubt  regarding the programming of bats in
function bat_mapin_ram().
     Here we are mapping  first 8 MB of ram  through  BAT2 and rest  4MB
of ram through
     BAT3 and the 4MB of ram remains unmapped.  Why is it so?
     Also, my kernel goes in panic with the above mentioned bat
programming.

     If  i  map the entire 16MB of ram through BAT2  everything works
fine.  So, should
     i map the entire ram with  BAT2???


    thanx and regards,
    -rd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
