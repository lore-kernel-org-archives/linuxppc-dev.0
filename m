Return-Path: <pedrol@163.com>
Received: from m13-79.163.com (m13-79.163.com [220.181.13.79])
	by ozlabs.org (Postfix) with SMTP id 96959DDF22
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 18:06:22 +1000 (EST)
Date: Tue, 3 Jun 2008 15:51:15 +0800 (CST)
From: pedrol <pedrol@163.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <24952919.541821212479475605.JavaMail.coremail@bj163app79.163.com>
Subject: problems with porting linux 2.6 kernel to xupv2p
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_143551_33412171.1212479475603"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_143551_33412171.1212479475603
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

Hello,
  All.I'm a student of Northeastern University, P.R.C. I am trying to port linux kennel 2.6 to xilinx virtex 2 board(xupv2p). I use the kernel 2.6.22.16 and its patch from kernel.org, but the kernel hangs at "now booting the kernel". Then I use the there patches of wolfgang from http://patchwork.ozlabs.org/linuxppc-embedded/. When I compile the kernel, it hangs with the error from patch 3, which has the neme of [PATCH 3-3] Add support for xupv2p and ml410 boards. The errors appear in the file xilinx_xupv2p.c. First, the kernel couldn't find the file linux/xilinx_devices.h. Then, there are lots of errors like "dereferencing pointer to incomplete type" in the function "virtex_device_fixup". I wonder if I use the right patch that the kernel needs. And I try to compile the kernle without the third patch. Then the kernel hangs just at "now booting the kernel". I am just exhausted with the work. Could anybody give me some help? I will be very glad to get some help from him. 

pedrol
2008.6.3 

 
 
------=_Part_143551_33412171.1212479475603
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<DIV>
<DIV>Hello,<BR>&nbsp; All.I'm a student of Northeastern University, P.R.C. =
I am trying to port linux kennel 2.6 to xilinx virtex 2 board(xupv2p). I us=
e the kernel 2.6.22.16 and its patch from kernel.org, but the kernel hangs =
at "now booting the kernel". Then I use the there patches of wolfgang from =
<A href=3D"http://patchwork.ozlabs.org/linuxppc-embedded/">http://patchwork=
ozlabs.org/linuxppc-embedded/</A>. When I compile the kernel, it hangs wit=
h the error from patch 3, which has the neme of [PATCH 3-3] Add support for=
 xupv2p and ml410 boards. The errors appear in the file xilinx_xupv2p.c. Fi=
rst, the kernel couldn't find the file linux/xilinx_devices.h. Then, there =
are lots of errors like "dereferencing pointer to incomplete type" in the f=
unction "virtex_device_fixup". I wonder if I use the right patch that the k=
ernel needs. And I try to compile the kernle without the third patch. Then =
the kernel hangs just at "now booting the kernel". I am just exhausted with=
 the work. Could&nbsp;anybody give me some help? I will be very glad to get=
 some help from him. </DIV>
<DIV><BR>pedrol<BR>2008.6.3 <BR></DIV></DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV><br><!-- footer --><br>=20
<hr>
<font style=3D"font-size:12px;line-height:15px;"></font><a style=3D"font-si=
ze:12px;line-height:15px; color:blue; text-decoration:underline;" href=3D"h=
ttp://popme.163.com/link/003982_0602_7547.html">=C8=FD=C5=CC=C1=AA=B6=AF=A3=
=AC=C6=F0=BC=DB4300</a>
------=_Part_143551_33412171.1212479475603--
