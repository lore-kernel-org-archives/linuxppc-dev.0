To: linuxppc-dev@lists.linuxppc.org
Subject: "unhandled relocation type 18" ???
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Date: Mon, 05 Mar 2001 20:09:21 +0100
Message-Id: <20010305190926.8ED2E287EA@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

when trying to "insmod" a  kernel  module  that  uses  floating-point
functions  like  "sin", we get error messages:

	unhandled relocation type 18

This is on a MPC8xx CPU with kernel 2.4.x, modutils-2.4.1; the module
and all code linked with it was compiled with "-msoft-float".


[Before you ask why we are doing something like that: it's for RTAI.]

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Why is an average signature file longer than an average Perl script??

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
