Content-Type: text/plain
MIME-Version: 1.0
Message-ID: <I3969671769684.06141@webmail4.inner-21cn.com>
Date: Fri, 28 Mar 2003 23:03:15 +0800 (CST)
From: "li" <slowforce@21cn.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: 
Subject: XPC850SR from 48M to 80M
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
i am going to raise xpc850SR freq from 48M to 80M.
with the ppcboot-1.1.6, i still set the freq to 48M,
and i change the freq to 80M in linux kernel file m8xx_setup.c, but when the kernel booting, the console outputs mass characters. i think there must be something wrong about the serial setup. But where is it?
And if it can work i set the different cpu freq in boot an in kernel?
Thanks in advance!
Li


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
