Message-ID: <3E95E275.1050002@kegel.com>
Date: Thu, 10 Apr 2003 14:30:29 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: jack.sun@bmrtech.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: re: Linux crash when big application executing on PPC405GP board
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


jack.sun@bmrtech.com wrote:
> Board: CSB272 IBM PPC405GP
> Linux kernel version: 2.4.17
> Linux kernel can boot nfs root filesystem on the board. Shell works
> correctly.
> However the system will oops when execute big applications, such as
> copying a file which is larger than 2MBytes.
> The following is ksymoops:
>
> The size of vmlinux.srec is 2.076Mbytes.
> root@192.9.200.145:/# cp vmlinux.srec vmlinux.srec.bak
>
> Oops: kernel access of bad area, sig: 11

Where did you get your kernel?
What compiler did you use to build it?
- Dan

--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
