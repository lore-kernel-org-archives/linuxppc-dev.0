Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <D73A25AA6E54D511AD74009027B1110F3C0A08@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Qsyang'" <yangqs@163.com>, linuxppc-embedded@lists.linuxppc.org
Subject: RE: debug irregularly!
Date: Fri, 29 Aug 2003 09:56:49 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Most likely you are compiling with optimization enabled.  This can cause the
c code to execute in a different sequence than you wrote.

-----Original Message-----
From: Qsyang [mailto:yangqs@163.com]
Sent: Friday, August 29, 2003 5:50 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: debug irregularly!



hi,there
          when i debug(debugger=BDI2000;cpu=8xx) U-boot in flash, it
jumps irregularly as it running into "C" code, which always trouble me
-<. How can i get a "normal" debug sequence? is it need to add some
debug parameter into config.mk?
          thanks for any help !
　　　　　　　　Qsyang
　　　　　　　　yangqs@163.com
　　　　　　　　　　2003-08-29


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
