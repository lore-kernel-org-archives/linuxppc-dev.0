From: Brian Waite <waite@skycomputers.com>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Disable cache on 74xx
Date: Wed, 19 Feb 2003 15:52:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200302191552.01911.waite@skycomputers.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,
	I am trying to hunt down a memory controller configuration problem and I have
been asked to disable all caching so as to remove it from the equation. I can
easl disable L2 but when I start ucking with the WIMG bits to set cache
inhibit, The kernel panics with stack overflows. Does anyone know where or
what I have to set to disable caching?

Thanks
Brian

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
