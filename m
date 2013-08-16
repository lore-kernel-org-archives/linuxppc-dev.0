Return-Path: <hbausley@deltatau.com>
Received: from Barracuda.deltatau.com (barracuda.deltatau.com [76.79.246.10])
 by ozlabs.org (Postfix) with ESMTP id 18A802C01E5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 15:11:09 +1000 (EST)
Received: from mail.deltatau.com (mail.deltatau.com [76.79.246.9]) by
 Barracuda.deltatau.com with ESMTP id IceDPzzDDz6QcJbX for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 21:57:20 -0700 (PDT)
From: "Henry Bausley" <hbausley@deltatau.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Critical Interrupt Input
Date: Thu, 15 Aug 2013 21:57:01 -0700
Message-ID: <4724f96e$5f998126$5fb2b995$@deltatau.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_0001_1796FBF9.253BF7F0"
Reply-To: hbausley@deltatau.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.

------=_NextPart_000_0001_1796FBF9.253BF7F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit


Is there any reason that a Critical Input Interrupt will not work reliably 
on a 44x powerpc?

I am using an AMCC now Applied Micro AMCC460EX 

and changed

CRITICAL_EXCEPTION(0x0100, CriticalInput, unknown_exception)
to
CRITICAL_EXCEPTION(0x0100, CriticalInput, do_MyCritIntr)

The code for the handler is trivial
ie.
int crintrcount;

void do_MyCritIntr(void)
{
  crintrcount++;
}

The code runs for a while but eventually I get panic messages and  the 
system hangs.  Is there something I must alter in the kernel to do this 
reliably?



Outbound scan for Spam or Virus by Barracuda at Delta Tau


------=_NextPart_000_0001_1796FBF9.253BF7F0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<span style=3D"font-family: Tahoma, Geneva, sans-serif; font-size: 10pt"><b=
r>Is there any reason that a Critical Input Interrupt will not work reliabl=
y on a 44x powerpc?<br><br>I am using an AMCC now Applied Micro AMCC460EX <=
br><br>and changed<br><br>CRITICAL_EXCEPTION(0x0100, CriticalInput, unknown=
_exception)<br>to<br>CRITICAL_EXCEPTION(0x0100, CriticalInput, do_MyCritInt=
r)<br>
<br>The code for the handler is trivial<br>ie.<br>int crintrcount;<br><br>v=
oid do_MyCritIntr(void)<br>{<br>&nbsp; crintrcount++;<br>}<br><br>The code =
runs for a while but eventually I get panic messages and&nbsp; the system h=
angs.&nbsp; Is there something I must alter in the kernel to do this reliab=
ly?<br><div></div></span>
<br>
&nbsp;&nbsp;&shy;&shy;&nbsp;&nbsp;=

------=_NextPart_000_0001_1796FBF9.253BF7F0--
