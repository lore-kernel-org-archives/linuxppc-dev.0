Message-Id: <36CDED59.65562A34@pop.agri.ch>
Date: Sat, 20 Feb 1999 00:01:48 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Mime-Version: 1.0
To: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Libg++2.8.x build
Content-Type: multipart/mixed; boundary="------------D122D63C4C93698D0C320477"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------D122D63C4C93698D0C320477
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, 
I know you are further than me and you are working at least with > egcs 1.0.2
and > libg++. But I can't, due to the vtable bug. So I try to build libg++
2.8.0.1. But I got the following errors:
See Attachment.

Does anybody of you have an idea where to setup the work? I think it should be
possible to bring this to work since I have dl/d the source as rpm. So I
suppose there was a least a person before who did that.
Two words to my config: kernel 2.2.0; glibc 2.0.108 >> pre R5!!

Thanks for any hints

Andreas
-- 
------------------
| Andreas Tobler								
| CH-8004 Zuerich	
| E-mail: toa@pop.agri.ch		
------------------------------------------
--------------D122D63C4C93698D0C320477
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="522A6368"; name="libg++2.8.log"
Content-Description: BBEdit Lite 4.0 Document
Content-Disposition: inline; filename="libg++2.8.log"
Content-Transfer-Encoding: 7bit

make[1]: Entering directory `/usr/src/redhat/BUILD/libg++/libraries/libio'
test -z "-fPIC" || \
  c++ -c -O2 -fsigned-char -fno-implicit-templates -I. -I. -nostdinc++ -D_IO_MTSAFE_IO -fPIC builtinbuf.cc -o pic/builtinbuf.o
In file included from streambuf.h:36,
                 from builtinbuf.h:32,
                 from builtinbuf.cc:29:
libio.h:270: invalid exception specifications
libio.h:271: invalid exception specifications
libio.h:272: invalid exception specifications
libio.h:273: invalid exception specifications
In file included from iostreamP.h:26,
                 from builtinbuf.cc:30:
libioP.h:94: invalid exception specifications
libioP.h:100: invalid exception specifications
libioP.h:107: invalid exception specifications
libioP.h:119: invalid exception specifications
libioP.h:126: invalid exception specifications
libioP.h:133: invalid exception specifications
libioP.h:143: invalid exception specifications
libioP.h:156: invalid exception specifications
libioP.h:164: invalid exception specifications
libioP.h:170: invalid exception specifications
libioP.h:176: invalid exception specifications
libioP.h:194: invalid exception specifications
libioP.h:201: invalid exception specifications
libioP.h:209: invalid exception specifications
libioP.h:219: invalid exception specifications
libioP.h:226: invalid exception specifications
libioP.h:233: invalid exception specifications
libioP.h:238: invalid exception specifications
libioP.h:453: invalid exception specifications
make[1]: *** [builtinbuf.o] Error 1
make[1]: Leaving directory `/usr/src/redhat/BUILD/libg++/libraries/libio'
make: *** [all-target-libio] Error 2

--------------D122D63C4C93698D0C320477--


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
