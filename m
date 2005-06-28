Return-Path: <Srivatsan.CR@in.flextronics.com>
Received: from SGPMX1.asia.ad.flextronics.com (unknown [203.208.243.76])
	by ozlabs.org (Postfix) with ESMTP id 4E2F667B5E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Jun 2005 19:21:40 +1000 (EST)
Message-ID: <3B58B875DBDE504F94D2A1A1C9DF6F1F01271EE8@bglnt005.asia.ad.flextronics.com>
From: Srivatsan CR <Srivatsan.CR@in.flextronics.com>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 28 Jun 2005 10:11:19 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C57B9B.A0CD17B0"
Cc: Chandrasekhar C <Chandrasekhar.C@in.flextronics.com>
Subject: GCC 3.3.1 unsigned long long issue on Powerpc 7xx 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C57B9B.A0CD17B0
Content-Type: text/plain

Dear all,

     We are using a third party software (support is not available :-( )
which uses unsigned long long in the code (both 
     kernel and user space). 

     We are trying to compile the same using the flag "-std=c99" (Changes
made to the CFLAGS option in Kernel and user 
     space Makefiles). For this we removed the -ansi option from CFLAGS
(both Kernel and user space Makefiles). The  
     compiler being used is GCC 3.3.1 on a 7xx platform.

     Using the above mentioned method, user space code compiles properly but
the kernel code gives errors. Is there any 
     workaround to be done on the Kernel Makefile so that it compiles
without errors?

     Requesting all your help to solve the issue. Thanks in advance for all
the help extended. 

With Best Regards,
C.R.Srivatsan

------_=_NextPart_001_01C57B9B.A0CD17B0
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DUS-ASCII">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2653.12">
<TITLE>GCC 3.3.1 unsigned long long issue on Powerpc 7xx </TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Dear all,</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp; We are using a third party =
software (support is not available :-( ) which uses unsigned long long =
in the code (both </FONT></P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp; kernel and user space). =
</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp; We are trying to compile the =
same using the flag &quot;-std=3Dc99&quot; (Changes made to the CFLAGS =
option in Kernel and user </FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp; space Makefiles). For this =
we removed the -ansi option from CFLAGS (both Kernel and user space =
Makefiles). The&nbsp; </FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp; compiler being used is GCC =
3.3.1 on a 7xx platform.</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp; Using the above mentioned =
method, user space code compiles properly but the kernel code gives =
errors. Is there any </FONT></P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp; workaround to be done on the =
Kernel Makefile so that it compiles without errors?</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp; Requesting all your help to =
solve the issue. Thanks in advance for all the help extended. </FONT>
</P>

<P><FONT SIZE=3D2>With Best Regards,</FONT>
<BR><FONT SIZE=3D2>C.R.Srivatsan</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C57B9B.A0CD17B0--
