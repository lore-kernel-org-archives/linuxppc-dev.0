Date: Tue, 13 Jul 2004 15:14:18 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: gcc 3.5 compile errors with 2.6.8
Message-ID: <20040713131418.GA29768@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


gcc 3.5 doesnt allow static vs. non-static declarations anymore:

arch/ppc/kernel/time.c:92: error: static declaration of 'time_offset' follows non-static declaration
include/linux/timex.h:292: error: previous declaration of 'time_offset' was here

arch/ppc/syslib/open_pic.c:36: error: static declaration of 'OpenPIC' follows non-static declaration
arch/ppc/syslib/open_pic_defs.h:175: error: previous declaration of 'OpenPIC' was here


I'm not sure how to fix the time_offset part.

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
