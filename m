From: tom_gall@vnet.ibm.com
Message-ID: <39478BE8.3B6E6157@vnet.ibm.com>
Date: Wed, 14 Jun 2000 13:43:04 +0000
Reply-To: tom_gall@vnet.ibm.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.0-test1 linux/sched.h
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Anyone notice that on

2.4.0-test1-ac18 that sched.h was changed to remove

#define PF_PTRACED 0x00000010
#define PF_TRACESYS 0x00000020

I need both of these systems to get a successful zImage built for my Power3 box.
Anyone know why there were removed, do we really really need this or should
dependancies on these symbols go?

Regards,

Tom

--
Tom Gall - PowerPC Linux Team    "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@uswest.net
http://oss.software.ibm.com/developerworks/opensource/linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
