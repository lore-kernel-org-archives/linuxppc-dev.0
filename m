Return-Path: <jxnuxdy@163.com>
Received: from m13-13.163.com (m13-13.163.com [220.181.13.13])
	by ozlabs.org (Postfix) with SMTP id EF08367B52
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Jun 2006 12:09:17 +1000 (EST)
MIME-Version: 1.0
Message-ID: <44A1E115.000001.12247@bj163app13.163.com>
Date: Wed, 28 Jun 2006 09:53:25 +0800 (CST)
From: "Denny" <jxnuxdy@163.com>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>,
	"wolfgangdenk" <wd@denx.de>
Subject: Can anyone tell me if it is a bug of the
 ELDK4.0?
References: <mailman.1133.1151372366.11183.linuxppc-embedded@ozlabs.org>
	<OF10AE4861.E394E791-ON4825719A.004971D0-4825719A.004991C4@celestica.com>
	<e7rcok$fe9$1@sea.gmane.org>
In-Reply-To: <e7rcok$fe9$1@sea.gmane.org>
Content-Type: Multipart/Alternative;
	boundary="Boundary-=_mSGFueLQmlijlScmvjZYCpBzZvPU"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Boundary-=_mSGFueLQmlijlScmvjZYCpBzZvPU
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 7bit

Hi,
 
     I failed to compile the uboot on my 440GP platform, I set the compile switch as "-m440 -mcpu=440",
    
      But the interest thing is when I change the switch to "-m405 -mcpu=440", I can compile my uboot successfully, why?
 
      Also I find all the instructions are existed both in user manual of PPC_405 and PPC440. 
   
 
make[1]: Leaving directory `/opt/glacier_boot/post/cpu'
ppc_4xx-gcc -Wa,-gstabs -D__ASSEMBLY__ -g  -Os   -fPIC -ffixed-r14 -meabi -fno-strict-aliasing -D__KERNEL__ -DTEXT_BASE=0xFFC40000 -I/opt/glacier_boot/include -fno-builtin -ffreestanding -nostdinc -isystem /opt/eldk4.0/usr/bin/../lib/gcc/powerpc-linux/4.0.0/include -pipe  -DCONFIG_PPC -D__powerpc__ -DCONFIG_4xx -ffixed-r2 -ffixed-r29 -mstring -Wa,-m440 -mcpu=440 -msoft-float -c -o cpu/ppc4xx/start.o /opt/glacier_boot/cpu/ppc4xx/start.S
/opt/glacier_boot/cpu/ppc4xx/start.S: Assembler messages:
/opt/glacier_boot/cpu/ppc4xx/start.S:996: Error: Unrecognized opcode: `mfdccr'
/opt/glacier_boot/cpu/ppc4xx/start.S:998: Error: Unrecognized opcode: `mtdccr'
/opt/glacier_boot/cpu/ppc4xx/start.S:1016: Error: Unrecognized opcode: `mtdccr'
/opt/glacier_boot/cpu/ppc4xx/start.S:1027: Error: Unrecognized opcode: `mticcr'
/opt/glacier_boot/cpu/ppc4xx/start.S:1033: Error: Unrecognized opcode: `mticcr'
/opt/glacier_boot/cpu/ppc4xx/start.S:1039: Error: Unrecognized opcode: `mficcr'
/opt/glacier_boot/cpu/ppc4xx/start.S:1050: Error: Unrecognized opcode: `mtdccr'
/opt/glacier_boot/cpu/ppc4xx/start.S:1059: Error: Unrecognized opcode: `mtdccr'
/opt/glacier_boot/cpu/ppc4xx/start.S:1064: Error: Unrecognized opcode: `mfdccr'
make: *** [cpu/ppc4xx/start.o] Error 1
[root@localhost glacier_boot]# 
 
 
 
--Boundary-=_mSGFueLQmlijlScmvjZYCpBzZvPU
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<DIV>Hi,</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp; I failed to compile the uboot on my 440GP p=
latform, I set the compile switch as "-m440 -mcpu=3D440",</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;But the interest thing is when I chan=
ge the switch to "-m405 -mcpu=3D440", I can compile my uboot successfully=
, why?</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Also I&nbsp;find all the instruc=
tions are existed both in user manual of PPC_405 and PPC440.&nbsp;</DIV>
<DIV>&nbsp;&nbsp; </DIV>
<DIV>&nbsp;</DIV>
<DIV>make[1]: Leaving directory `/opt/glacier_boot/post/cpu'<BR>ppc_4xx-g=
cc -Wa,-gstabs -D__ASSEMBLY__ -g&nbsp; -Os&nbsp;&nbsp; -fPIC -ffixed-r14 =
-meabi -fno-strict-aliasing -D__KERNEL__ -DTEXT_BASE=3D0xFFC40000 -I/opt/=
glacier_boot/include -fno-builtin -ffreestanding -nostdinc -isystem /opt/=
eldk4.0/usr/bin/../lib/gcc/powerpc-linux/4.0.0/include -pipe&nbsp; -DCONF=
IG_PPC -D__powerpc__ -DCONFIG_4xx -ffixed-r2 -ffixed-r29 -mstring -Wa,-m4=
40 -mcpu=3D440 -msoft-float -c -o cpu/ppc4xx/start.o /opt/glacier_boot/cp=
u/ppc4xx/start.S<BR>/opt/glacier_boot/cpu/ppc4xx/start.S: Assembler messa=
ges:<BR>/opt/glacier_boot/cpu/ppc4xx/start.S:996: Error: Unrecognized opc=
ode: `mfdccr'<BR>/opt/glacier_boot/cpu/ppc4xx/start.S:998: Error: Unrecog=
nized opcode: `mtdccr'<BR>/opt/glacier_boot/cpu/ppc4xx/start.S:1016: Erro=
r: Unrecognized opcode: `mtdccr'<BR>/opt/glacier_boot/cpu/ppc4xx/start.S:=
1027: Error: Unrecognized opcode: `mticcr'<BR>/opt/glacier_boot/cpu/ppc4x=
x/start.S:1033: Error: Unrecognized opcode: `mticcr'<BR>/opt/glacier_boot=
/cpu/ppc4xx/start.S:1039: Error: Unrecognized opcode: `mficcr'<BR>/opt/gl=
acier_boot/cpu/ppc4xx/start.S:1050: Error: Unrecognized opcode: `mtdccr'<=
BR>/opt/glacier_boot/cpu/ppc4xx/start.S:1059: Error: Unrecognized opcode:=
 `mtdccr'<BR>/opt/glacier_boot/cpu/ppc4xx/start.S:1064: Error: Unrecogniz=
ed opcode: `mfdccr'<BR>make: *** [cpu/ppc4xx/start.o] Error 1<BR>[root@lo=
calhost glacier_boot]# </DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV><SPAN ></SPAN><br><!-- footer --><br><br><br><br><br><di=
v style=3D"border-bottom:1px solid #999"></div><br>

=09<font color=3D"black" style=3D"font-size:14.8px">=C4=E3 =B2=BB =CF=EB =
=CA=D4 =CA=D4 =BD=F1 =CF=C4 =D7=EE =A1=B0=BF=E1=A1=B1 =B5=C4 =D3=CA =CF=E4=
 =C2=F0 =A3=BF</font>
=09<br>
=09 <a href=3D"http://www.126.com/" target=3D"_blank" style=3D"font-size:=
13px;line-height:160%;color:blue">=D4=CC =BA=AD =D6=D0 =BB=AA =B4=AB =CD=B3=
 =CE=C4 =BB=AF =D3=DA =CA=C0 =BD=E7 =D2=BB =C1=F7 =BF=C6 =BC=BC =D6=AE =D6=
=D0=A3=AC=B4=B4 =D0=C2 Ajax =BC=BC =CA=F5=A3=AC126 =A1=B0D =BC=C6 =BB=AE=A1=
=B1=BB=F0 =C8=C8 =CC=E5 =D1=E9 =D6=D0 =A3=A1
</a>


--Boundary-=_mSGFueLQmlijlScmvjZYCpBzZvPU--
