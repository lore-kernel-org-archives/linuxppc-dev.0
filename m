Message-ID: <004201be8590$7c2c1080$66f102de@sjzhu>
Reply-To: "Shuangjun Zhu (r44089)" <r44089@email.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: <linuxppc-dev@lists.linuxppc.org>
Cc: "Cort Dougan" <cort@persephone.cs.nmt.edu>
Subject: Problem about Boot Image
Date: Tue, 13 Apr 1999 17:31:59 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="gb2312"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hello,
   In my built image zvmlinux.initrd,
the address of vmlinux.gz is overlap with .comment segment and BSS segment.
At the beginning of the boot, head.S clear the BSS segment
and .stack is in .comment segment. So they crash the vmlinux.gz image
before the system decompress it.
Does anyone know how to control to store vmlinux.gz image into .data
segment?
Thanks in advaced !

Best Regards
Zhu Shuangjun



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
