Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7AEB9ABC-C067-11D8-8413-000393DBC2E8@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: RFC: Addition of a MAINTAINERS file in arch/ppc/platforms
Date: Thu, 17 Jun 2004 09:06:08 -0500
To: Paul Mackerras <paulus@samba.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul,

I was wondering what your thoughts were about adding a MAINTAINERS file
in arch/ppc/platforms for all the various boards we have.  This will
hopefully help if someone needs to make changes to a family but can
fix/test all the boards for that sub-arch.

One thing to think about is does our move to sub-arching the platforms
directory effect things.

Today:
arch/ppc/platforms
				/4xx
				/85xx

future:
				/826x
				/8xx

- kumar


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
