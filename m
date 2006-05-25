Return-Path: <hangtoo@163.com>
Received: from m13-85.163.com (m13-85.163.com [220.181.13.85])
	by ozlabs.org (Postfix) with SMTP id 4759167A42
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 May 2006 17:26:15 +1000 (EST)
MIME-Version: 1.0
Message-ID: <44755859.0000CD.04146@bj163app85.163.com>
Date: Thu, 25 May 2006 15:10:17 +0800 (CST)
From: "hangtoo" <hangtoo@163.com>
To: "li yang-r58472" <leoli@freescale.com>
Subject: Re: RE: delay programming
Content-Type: Multipart/Alternative;
	boundary="Boundary-=_PlqGWezynSiVDAfNzPRfMipmAPIP"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Boundary-=_PlqGWezynSiVDAfNzPRfMipmAPIP
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 7bit

hi,
    yes,you are right.the usleep didn't give out accurate delay.so I make a delay funtion to fix it.
   thank you for you help.:)
regards
tony
 


That depends on how accurate you want.  Sleep() functions can't be too accurate 
for Linux schedule characteristic.  To get best accuracy, you can use hardware
timer.  udelay() is a choice which reduces the overall system performance.

Best Regards,
Leo


> -----Original Message-----
> From: linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leoli=freescale.com@ozlabs.org] On Behalf
> Of tony
> Sent: Wednesday, May 24, 2006 5:24 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: delay programming
> 
> 
> hi all
> 	I want to delay 1ms in the program,
> 	does usleep(1000) works accurate?
> 	any good idea?
> 
> regards
> tony
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

--Boundary-=_PlqGWezynSiVDAfNzPRfMipmAPIP
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<DIV>hi,</DIV>
<DIV>&nbsp;&nbsp;&nbsp; yes,you are right.the usleep didn't give out accu=
rate delay.so I make a delay funtion to fix it.</DIV>
<DIV>&nbsp;&nbsp; thank you for you help.:)</DIV>
<DIV>regards</DIV>
<DIV>tony</DIV>
<DIV>&nbsp;</DIV>
<DIV><BR><BR><PRE style=3D"WIDTH: 100%; WORD-WRAP: break-word">That depen=
ds on how accurate you want.  Sleep() functions can't be too accurate=20
for Linux schedule characteristic.  To get best accuracy, you can use har=
dware
timer.  udelay() is a choice which reduces the overall system performance=
=2E

Best Regards,
Leo


&gt; -----Original Message-----
&gt; From: linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
&gt; [<A href=3D"mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@o=
zlabs.org" target=3D_new>mailto:linuxppc-embedded-bounces+leoli=3Dfreesca=
le.com@ozlabs.org</A>] On Behalf
&gt; Of tony
&gt; Sent: Wednesday, May 24, 2006 5:24 PM
&gt; To: linuxppc-embedded@ozlabs.org
&gt; Subject: delay programming
&gt;=20
&gt;=20
&gt; hi all
&gt; =09I want to delay 1ms in the program,
&gt; =09does usleep(1000) works accurate?
&gt; =09any good idea?
&gt;=20
&gt; regards
&gt; tony
&gt;=20
&gt;=20
&gt; _______________________________________________
&gt; Linuxppc-embedded mailing list
&gt; Linuxppc-embedded@ozlabs.org
&gt; https://ozlabs.org/mailman/listinfo/linuxppc-embedded
</PRE><!-- CoreMail Version 2.5 Copyright (c) 2002-2006 www.mailtech.cn -=
-></DIV><br><!-- footer --><br><br><br><br><br><div style=3D"border-botto=
m:1px solid #999"></div><br>

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


--Boundary-=_PlqGWezynSiVDAfNzPRfMipmAPIP--
