Message-ID: <001801bfb31a$8b816d60$54c809c0@zbc>
From: "zhangbingchen" <shenhuizhang@263.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: how to extend the initrd to a customed size ?
Date: Mon, 1 May 2000 11:08:30 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!
  I have a board of Custom 860 with 16M RAM memory,which is running the specific linux kernel
  mpc8xx-2.1.3 obtained from bossek.now,I desire to enlarge the size of initrd from 4M to 6M to
 enable the initrd to contain the gigantic libc.so.6 with the size of morethan 4M;to do so,i have modified
 the line rd_size=6144 in .../drivers/block/rd.c file and the ramdisk.image has also been modified correspondly by now.
 But,to my puzzled,the console just displays the panic message:No init found and then reboots while running.
  I am sure there is no wrong with my ramdisk.image since it can be mountted correctly with
 6M size.
 That is all and I 'd be very thankful with your help or suggestion.

   regards
   john , zhang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
