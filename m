Message-ID: <006401c0af6f$4d1c39e0$8021690a@huawei.com>
From: "michael" <dony.he@huawei.com.cn>
To: "Dan Malek" <dan@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: shell prompt cannot appear after "Freeing unused kernel memory:..."
Date: Sun, 18 Mar 2001 13:50:13 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello:
    I use ppcboot and can boot kernel with NFS filesystems on my custom
board now. But problem occurs ...
   When it shows the following:
####################################
         ...........................
        "VFS:Mounted root(nfs filesystem)".
        Freeing unused kernel memory:44k init
####################################

At this moment I should have seen "sash#" ,but  nothing happens . I cannot
see anything.

I remember that there is a patch for this when I boot kernel on my 860 based
custom board last year(linux-2.2.13+860).
I don't know if this can work for my 8260 based custom board
now(linux-2.4.1+8260).
Can you help me?

Thank you very much.

michael


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
