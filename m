From: "Daniel Lao" <laodx@gzjpg.com>
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: About the process's logical space :-(
Mime-Version: 1.0
Content-Type: text/plain
Date: Fri, 1 Nov 2002 9:41:53 +0800
Message-Id: <200211011030515.SM00332@xuyf>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have used the linuxppc development env. with 2.2.12 kernel, the process can only map to the logical address between 0x0 - 0x80000000. But under the redhat (kernel 2.2.5, x86), I can map to 0x0 - 0xC0000000!!!
Is the 2.4.x ppc kernel also have the limit?

---
Daniel Lao
2002-11-01 09:32:25

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
