Return-Path: <vencent2006@163.com>
Received: from m13-110.163.com (m13-110.163.com [220.181.13.110])
	by ozlabs.org (Postfix) with SMTP id 13404DDF0B
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 22:39:52 +1000 (EST)
Date: Wed, 28 May 2008 20:24:40 +0800 (CST)
From: vencent2006 <vencent2006@163.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <12692943.1528961211977480208.JavaMail.coremail@bj163app110.163.com>
Subject: May I ask some questions?
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_408787_14033842.1211977480207"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_408787_14033842.1211977480207
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

 I am Michael from China.A few days ago, I was supposed to debug executable.elf with xmd while some problems happened.It said like that:
 xmd% dow executable.elf
 Failed to download ELF file
 
ERROR(1053):UNABLE TO READ ELF FILE.THE ELF FILE
            MAYBE CORRUPTED
     :executable.elf
 
I wanna ask u to point out what causes this problem.
 
There is another question about "xparameters.h" and 
"xparameters_ml300.h". When I have generated BSP, there are two "xparameters.h" files in project which
 have the same name while different size(eg: one is 22k ,the other is 4k). Which one is the proper? 
And when I add "xparameters.h" and "xparameters_ml300.h" to the kernel, some compiling 
error occurs.
  eg:
arch/ppc/syslib/virtex_devices.c:116: error: 'XPAR_UARTNS550_0_CLOCK_FREQ_HZ' undeclared here (not in a function)
arch/ppc/syslib/virtex_devices.c:119: error: 'XPAR_UARTNS550_1_CLOCK_FREQ_HZ' undeclared here (not in a function)
 I don't understand where to define them and whether i need them or not.
  my eldk is:eldk/4.2/ppc-linux-x86
  using Xilinx EDK/ISE 9.1
  Linux 2.6.24
  
 
 
 
 

--

------=_Part_408787_14033842.1211977480207
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<DIV>&nbsp;I am Michael from China.A few&nbsp;days ago,&nbsp;I&nbsp;was sup=
posed to&nbsp;debug executable.elf&nbsp;with xmd while some problems happen=
ed.It said like that:</DIV>
<DIV>&nbsp;xmd% dow executable.elf</DIV>
<DIV>&nbsp;Failed to download ELF file</DIV>
<DIV>&nbsp;</DIV>
<DIV>ERROR(1053):UNABLE TO READ ELF FILE.THE ELF FILE</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MAY=
BE CORRUPTED</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp; :executable.elf</DIV>
<DIV>&nbsp;</DIV>
<DIV>I wanna ask u to point out what causes this problem.</DIV>
<DIV>&nbsp;</DIV>
<DIV>There is another question about "xparameters.h" and </DIV>
<DIV>"xparameters_ml300.h". When I have generated BSP, there are two "xpara=
meters.h" files in project which</DIV>
<DIV>&nbsp;have the same name while different size(eg: one is 22k ,the othe=
r is 4k). Which one is the proper? </DIV>
<DIV>And&nbsp;when I add "xparameters.h" and "xparameters_ml300.h" to the k=
ernel, some compiling </DIV>
<DIV>error occurs.</DIV>
<DIV>&nbsp; eg:</DIV>
<DIV>arch/ppc/syslib/virtex_devices.c:116: error: 'XPAR_UARTNS550_0_CLOCK_F=
REQ_HZ' undeclared here (not in a function)<BR>arch/ppc/syslib/virtex_devic=
es.c:119: error: 'XPAR_UARTNS550_1_CLOCK_FREQ_HZ' undeclared here (not in a=
 function)<BR>&nbsp;I don't understand where to define them and whether i n=
eed them or not.</DIV>
<DIV>&nbsp; my eldk is:eldk/4.2/ppc-linux-x86</DIV>
<DIV>&nbsp; using Xilinx EDK/ISE 9.1</DIV>
<DIV>&nbsp; Linux 2.6.24</DIV>
<DIV>&nbsp; </DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><BR>--<BR>
<DIV><FONT size=3D"6"></FONT></DIV></DIV><br><!-- footer --><br>=20
<hr>
<font style=3D"font-size:12px;line-height:15px;">=D1=DB=BE=A6=B8=C9=C9=AC=
=A3=BF=C8=F3=BD=E0=D2=BB=CF=C2=A3=A1=C7=E5=C1=B9=C5=E4=B7=BD=A3=AC=B6=E0=D6=
=D8=D3=AA=D1=F8=A3=AC</font><a style=3D"font-size:12px;line-height:15px; co=
lor:blue; text-decoration:underline;" href=3D"http://popme.163.com/link/004=
304_0515_8953.html">=BB=BA=BD=E2=D1=DB=C6=A3=C0=CD</a>
------=_Part_408787_14033842.1211977480207--
