Message-Id: <v03010d00b2fdb9273872@[209.96.179.170]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 27 Feb 1999 10:09:39 -0500
To: linuxppc-dev@lists.linuxppc.org, egcs@egcs.cygnus.com
From: "Kevin B. Hendricks" <kbhend@business.wm.edu>
Subject: PowerPC and egcs gurus: Help! egcs PPC Float Min != JCK Float Min
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


PowerPC and egcs Gurus,

I could really use some help here.  I am part of the Blackdown porting team
that is porting JDK 1.2 to linux for powerpc.  In order to do an offical
"release", our port must pass *all* of the Java Compatitiblity Kit (JCK)
tests.

One of the JCK tests tries to pass what it thinks Float_Min is back and forth.
The JCK says we *must* support a min Floating point value of
1.40239846e-45F but according to <float.h> in egcs our FLT_MIN on powerpc
is 1.17549435e-38F.  The Float max values are the same.

So we end up failing this test (and then can never offically release).

I don't know enough about the float modes (normalized vs de-normalized, vs
?) on the PPC chip to know if or how we can support such a min float value.

I could use some help here.  Do you know anything (or could you point me to
something or someone) that might explain, how the PPC processor can/will
support a min Float value of 1.40239846e-45F?

Is the FLT_MIN valkue in float.h of egcs, an egcs constraint or a real PPC
constraint?

Any ideas of how to get around this issue without have to write a floating
point emulation software library (and kill what little floating point
performance the JDK has)?


Any help would be greatly appreciated.

Thanks,

Kevin

Please cc in any replies, I am not on the egcs list.


p.s. Other that this issue, the JDK 1.2 is running very nicely on LinuxPPC
under green threads under Gary's glibc 1.99 clone and should now compile
cleanly under glibc 2.1 (when I finally get an R5 disk).




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
