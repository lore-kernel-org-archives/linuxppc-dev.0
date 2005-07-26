Return-Path: <Srivatsan.CR@in.flextronics.com>
Received: from bglnt005.asia.ad.flextronics.com (unknown [203.145.155.1])
	by ozlabs.org (Postfix) with ESMTP id BFE8C67C64
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 01:50:14 +1000 (EST)
Message-ID: <3B58B875DBDE504F94D2A1A1C9DF6F1F01A74186@bglnt005.asia.ad.flextronics.com>
From: Srivatsan CR <Srivatsan.CR@in.flextronics.com>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 26 Jul 2005 21:04:45 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C591F7.8CBB6C50"
Subject: [Newbie] Linux Warm Reboot question
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

------_=_NextPart_001_01C591F7.8CBB6C50
Content-Type: text/plain

Dear all,

     We are trying to perform a warm reboot on a MPC8260 based target but we
are unable to make the kernel jump to the correct location. Can anyone give
a brief on the RAM memory map Linux in use for these kind of processors ? 

What I got from going thro' the code in head.S (exception vector is mapped
from 0x0, then Linux Kernel starts. But not able to find the physical start
address of the Linux Kernel code).

Thanks for all the time.

With Regards,
C.R.Srivatsan

    

    
    

      

    
     

       


------_=_NextPart_001_01C591F7.8CBB6C50
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DUS-ASCII">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2653.12">
<TITLE>[Newbie] Linux Warm Reboot question</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Dear all,</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp; We are trying to perform a =
warm reboot on a MPC8260 based target but we are unable to make the =
kernel jump to the correct location. Can anyone give a brief on the RAM =
memory map Linux in use for these kind of processors ? </FONT></P>

<P><FONT SIZE=3D2>What I got from going thro' the code in head.S =
(exception vector is mapped from 0x0, then Linux Kernel starts. But not =
able to find the physical start address of the Linux Kernel =
code).</FONT></P>

<P><FONT SIZE=3D2>Thanks for all the time.</FONT>
</P>

<P><FONT SIZE=3D2>With Regards,</FONT>
<BR><FONT SIZE=3D2>C.R.Srivatsan</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; </FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; </FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp; </FONT>
<BR><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C591F7.8CBB6C50--
