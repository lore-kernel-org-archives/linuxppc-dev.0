Date: Mon, 18 Oct 1999 10:52:01 -0700
From: "David N. Welton" <davidw@linuxcare.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Kernel questions
Message-ID: <19991018105201.B17058@bassano.linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, I have several questions regarding the latest devel kernel
(2.3.22), that I am trying to get running on an RS6000.

1) Why does everything seem to want to access NVRAM things?  I've
   found it scattered in several places throughout the kernel, such as
   matroxfb.c.

2) Why is it trying to compile and use pmac_support (amongst other
   pmac_* things).  I have it set to the CHRP architecture.

3) Why does pmac_support.c assume that you have ADB stuff compiled in?

nvram_read_byte contains: "struct adb_request req".

If I have understood correctly, ADB is an Apple thing, and really
shouldn't have anything to do with my RS6000.  Is this correct?

I'm sorry if some of these are silly questions, and hope my ignorance
isn't too glaring:-)

Thanks,
-- 
David N. Welton, Developer, Linuxcare, Inc.
415.354.4878 x241 tel, 415.701.7457 fax
dwelton@linuxcare.com, http://www.linuxcare.com/
Linuxcare. At the center of Linux.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
