Return-Path: <malik_mca2000@yahoo.co.in>
Received: from n15b.bullet.mail.mud.yahoo.com (n15b.bullet.mail.mud.yahoo.com
	[68.142.207.236]) by ozlabs.org (Postfix) with SMTP id 074B1DE089
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 May 2008 23:14:22 +1000 (EST)
Date: Thu, 22 May 2008 18:38:54 +0530 (IST)
From: sandeep malik <malik_mca2000@yahoo.co.in>
Subject: Help needed in debugging the crash  of kernel stack overflow
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-61961985-1211461734=:89060"
Message-ID: <759615.89060.qm@web8413.mail.in.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-61961985-1211461734=:89060
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=0AWe are using MSC7120 (e300 based) board running Montavista Linux 2.4.=
 We are observing a random crash with the following dump:=0AKernel stack ov=
erflow in process c5b22000, r1=3Dc5b22460=0ANIP: 00000000 XER: 20000000 LR:=
 00000000 SP: C5B22460 REGS: c5b223b0 TRAP: 0400=C2=A0=C2=A0=C2=A0 Tainted:=
 P=0AMSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11=0ATASK =3D c5b22000[17=
5] 'insmod' Last syscall: -1=0Alast math 00000000 last altivec 00000000=0AG=
PR00: 00000000 C5B22460 C5B22000 C5B22470 00000000 20001032 00000000 000000=
00=0AGPR08: F0000700 00000000 00000008 00000001 24224482 1033BB30 00000000 =
00000000=0AGPR16: 00000000 00000000 00000000 00000001 00001032 05B22460 000=
00000 00000000=0AGPR24: 00000000 00000200 C7B09400 C016A240 C5B23D80 000000=
10 00000000 C7B09400=0ACall backtrace:=0A70536574 34205220 00000000 0000000=
0 00000000 55555555 55555555=0A55555555 55555555 55555555 55515555 55555555=
 55555555 55515555=0A55555555 55555555 494C450A 66363531 4F4E455F 35382054 =
38383053=0A20542056 43686563 53797353 35632052 70383830 74205670 0A636230=
=0A436D640A 38383053 24108028 C5C740C8 C00059AC=0AKernel panic: kernel stac=
k overflow=0AIn interrupt handler - not syncing=0AAny idea what might be go=
ing wrong or how to approach this problem as it is not getting reproduced a=
nd the behaviour is very random. Any pointers will be helpful.=0ARegards,=
=0ASM=0A=0A=0A      Forgot the famous last words? Access your message archi=
ve online at http://in.messenger.yahoo.com/webmessengerpromo.php
--0-61961985-1211461734=:89060
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV>Hi,</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>We are using MSC7=
120 (e300 based) board running Montavista Linux 2.4. We are observing a ran=
dom crash with the following dump:</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>Kernel =
stack overflow in process c5b22000, r1=3Dc5b22460<BR>NIP: 00000000 XER: 200=
00000 LR: 00000000 SP: C5B22460 REGS: c5b223b0 TRAP: 0400&nbsp;&nbsp;&nbsp;=
 Tainted: P<BR>MSR: 20001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11<BR>TASK =3D =
c5b22000[175] 'insmod' Last syscall: -1<BR>last math 00000000 last altivec =
00000000<BR>GPR00: 00000000 C5B22460 C5B22000 C5B22470 00000000 20001032 00=
000000 00000000<BR>GPR08: F0000700 00000000 00000008 00000001 24224482 1033=
BB30 00000000 00000000<BR>GPR16: 00000000 00000000 00000000 00000001 000010=
32 05B22460 00000000 00000000<BR>GPR24: 00000000 00000200 C7B09400 C016A240=
 C5B23D80 00000010 00000000 C7B09400<BR>Call backtrace:<BR>70536574 3420522=
0 00000000 00000000 00000000 55555555 55555555<BR>55555555 55555555 5555555=
5 55515555 55555555 55555555 55515555<BR>55555555 55555555 494C450A 6636353=
1 4F4E455F 35382054 38383053<BR>20542056 43686563 53797353 35632052 7038383=
0 74205670 0A636230<BR>436D640A 38383053 24108028 C5C740C8
 C00059AC<BR>Kernel panic: kernel stack overflow<BR>In interrupt handler - =
not syncing</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>Any idea what might be going w=
rong or how to approach this problem as it is not getting reproduced and th=
e behaviour is very random. Any pointers will be helpful.</DIV>=0A<DIV>&nbs=
p;</DIV>=0A<DIV>Regards,</DIV>=0A<DIV>SM</DIV></div><br>=0A=0A=0A      <!--=
2--><hr size=3D1></hr> Unlimited freedom, unlimited storage. <a href=3D"htt=
p://in.rd.yahoo.com/tagline_mail_2/*http://help.yahoo.com/l/in/yahoo/mail/y=
ahoomail/tools/tools-08.html/">Get it now</a></body></html>
--0-61961985-1211461734=:89060--
