Message-Id: <00Apr29.070611adt.7306@dragon.appliedmicro.ns.ca>
From: Frank Smith <smith@amirix.com>
MIME-Version: 1.0
To: zhangbingchen <shenhuizhang@263.net>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: how to extend the initrd to a customed size ?
References: <001801bfb31a$8b816d60$54c809c0@zbc>
Content-Type: text/plain; charset=us-ascii
Date: Sat, 29 Apr 2000 07:06:09 -0300
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If you strip libc.so.6 it gets much smaller; my specific version went from
4115403 to 1032312 bytes.

-Frank.


zhangbingchen wrote:
>
> Hello!
>   I have a board of Custom 860 with 16M RAM memory,which is running the specific linux kernel
>   mpc8xx-2.1.3 obtained from bossek.now,I desire to enlarge the size of initrd from 4M to 6M to
>  enable the initrd to contain the gigantic libc.so.6 with the size of morethan 4M;to do so,i have modified
>  the line rd_size=6144 in .../drivers/block/rd.c file and the ramdisk.image has also been modified correspondly by now.
>  But,to my puzzled,the console just displays the panic message:No init found and then reboots while running.
>   I am sure there is no wrong with my ramdisk.image since it can be mountted correctly with
>  6M size.
>  That is all and I 'd be very thankful with your help or suggestion.
>
>    regards
>    john , zhang
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
