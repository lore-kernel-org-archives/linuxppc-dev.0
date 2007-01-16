Return-Path: <junijoseph@yahoo.co.in>
Received: from web8414.mail.in.yahoo.com (web8414.mail.in.yahoo.com
	[202.43.219.102]) by ozlabs.org (Postfix) with SMTP id CD77DDDF61
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Jan 2007 10:27:16 +1100 (EST)
Message-ID: <20070116232034.40662.qmail@web8414.mail.in.yahoo.com>
Date: Tue, 16 Jan 2007 23:20:34 +0000 (GMT)
From: agnel juni <junijoseph@yahoo.co.in>
Subject: PCI IRQ -MPC8540
To: Kumar Gala <galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-737655938-1168989634=:37604"
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

--0-737655938-1168989634=:37604
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

Hello all:=0A=0AI would like to understand if there is a way to program the=
 PCI interrupt pin register of MPC8540. I did look for this in the datashee=
t, but couldn't find any positive answer.=0A=0ACurrently, I am working in a=
 set-up where MPC8540 is an agent, plugged into the PC host. =0AI couldn't =
get an IRQ for the card when plugged in some PCI slots, whereas in one of t=
he slots I do see a non-zero value.=0A=0AIt would be great if you could hel=
p me understand the issue.=0A=0AI am sorry if the question is inapporpriate=
 in the group. I am desperate to solve the issue.=0A=0AThanks for any help.=
=0AJ.Joseph=0A=0A----- Original Message ----=0AFrom: Kumar Gala <galak@kern=
el.crashing.org>=0ATo: Wang Matthew-R59995 <Qi.W@freescale.com>=0ACc: linux=
ppc-embedded@ozlabs.org=0ASent: Wednesday, 18 October, 2006 6:54:24 PM=0ASu=
bject: Re: Linuxppc-embedded Digest, Vol 26, Issue 36=0A=0A=0AOn Oct 18, 20=
06, at 8:10 PM, Wang Matthew-R59995 wrote:=0A=0A> Hi Kumar,=0A>=0A> Actuall=
y I do many trials about it. Vxwerks Bootrom is smaller than=0A> U-Boot. Th=
e key difference between Bootrom and U-boot is that some=0A> source code of=
 Bootrom is invisible to the users.=0A>=0A> Actually the rfi instruction wh=
ich I point out is the first rfi=0A> instruction of Linux PowerPC bringup.=
=0A>=0A> Before that, it's TLB entry invalidation and temp TLB entry mappin=
g.=0A>=0A> I check MMU setting carefully before coming Linux Kernel.=0A>=0A=
> I just want to know if other guys met similar scenario like me. I  =0A> d=
on't=0A> need the precise answer, just overall suggestion about it because =
I=0A> understand that not everyone has the same bootloader of mine, that=0A=
> bootloader is actually a customized bootloader.=0A=0AI understand that, t=
hus I was asking what exact problem you were  =0Aseeing to try and help.=0A=
=0A> Anyway thank you.=0A>=0A> R9 point to LR register, mask the high 20 bi=
t of r9 and send to r7,  =0A> and=0A> then add 24, which means stride 6 ins=
tructions for rfi instruction=0A> execution.=0A>=0A> Of course, rfi can swi=
tch the TLB entry, both the previous TLB  =0A> entry and=0A> the temp TLB e=
ntry point to the same physical address.=0A>=0A> I've checked it.=0A=0AI kn=
ow what the code does, I wrote it :)=0A=0A- kumar=0A=0A=0A=0A______________=
_________________________________=0ALinuxppc-embedded mailing list=0ALinuxp=
pc-embedded@ozlabs.org=0Ahttps://ozlabs.org/mailman/listinfo/linuxppc-embed=
ded=0A=0A=0A=0A=0A=0A=0A=0A=09=09=0A_______________________________________=
___________________=0AYahoo! India Answers: Share what you know. Learn some=
thing new=0Ahttp://in.answers.yahoo.com/
--0-737655938-1168989634=:37604
Content-Type: text/html; charset=iso-8859-7
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;">Hello all:<br><br>I would like to understand if the=
re is a way to program the PCI interrupt pin register of MPC8540. I did loo=
k for this in the datasheet, but couldn't find any positive answer.<br><br>=
Currently, I am working in a set-up where MPC8540 is an agent, plugged into=
 the PC host. <br>I couldn't get an IRQ for the card when plugged in some P=
CI slots, whereas in one of the slots I do see a non-zero value.<br><br>It =
would be great if you could help me understand the issue.<br><br>I am sorry=
 if the question is inapporpriate in the group. I am desperate to solve the=
 issue.<br><br>Thanks for any help.<br>J.Joseph<br><br><div style=3D"font-f=
amily: times new roman,new york,times,serif; font-size: 12pt;">----- Origin=
al Message
 ----<br>From: Kumar Gala &lt;galak@kernel.crashing.org&gt;<br>To: Wang Mat=
thew-R59995 &lt;Qi.W@freescale.com&gt;<br>Cc: linuxppc-embedded@ozlabs.org<=
br>Sent: Wednesday, 18 October, 2006 6:54:24 PM<br>Subject: Re: Linuxppc-em=
bedded Digest, Vol 26, Issue 36<br><br><div><br>On Oct 18, 2006, at 8:10 PM=
, Wang Matthew-R59995 wrote:<br><br>&gt; Hi Kumar,<br>&gt;<br>&gt; Actually=
 I do many trials about it. Vxwerks Bootrom is smaller than<br>&gt; U-Boot.=
 The key difference between Bootrom and U-boot is that some<br>&gt; source =
code of Bootrom is invisible to the users.<br>&gt;<br>&gt; Actually the rfi=
 instruction which I point out is the first rfi<br>&gt; instruction of Linu=
x PowerPC bringup.<br>&gt;<br>&gt; Before that, it's TLB entry invalidation=
 and temp TLB entry mapping.<br>&gt;<br>&gt; I check MMU setting carefully =
before coming Linux Kernel.<br>&gt;<br>&gt; I just want to know if other gu=
ys met similar scenario like me. I&nbsp;&nbsp;<br>&gt; don't<br>&gt; need t=
he precise
 answer, just overall suggestion about it because I<br>&gt; understand that=
 not everyone has the same bootloader of mine, that<br>&gt; bootloader is a=
ctually a customized bootloader.<br><br>I understand that, thus I was askin=
g what exact problem you were&nbsp;&nbsp;<br>seeing to try and help.<br><br=
>&gt; Anyway thank you.<br>&gt;<br>&gt; R9 point to LR register, mask the h=
igh 20 bit of r9 and send to r7,&nbsp;&nbsp;<br>&gt; and<br>&gt; then add 2=
4, which means stride 6 instructions for rfi instruction<br>&gt; execution.=
<br>&gt;<br>&gt; Of course, rfi can switch the TLB entry, both the previous=
 TLB&nbsp;&nbsp;<br>&gt; entry and<br>&gt; the temp TLB entry point to the =
same physical address.<br>&gt;<br>&gt; I've checked it.<br><br>I know what =
the code does, I wrote it :)<br><br>- kumar<br><br><br><br>________________=
_______________________________<br>Linuxppc-embedded mailing list<br>Linuxp=
pc-embedded@ozlabs.org<br><a target=3D"_blank"
 href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozl=
abs.org/mailman/listinfo/linuxppc-embedded</a><br></div></div><br></div></d=
iv><br>=0A=09=0A=0A=09=0A=09=09<hr size=3D1></hr> =0AHere=A2s a new way to =
find what you're looking for - <a href=3D"http://us.rd.yahoo.com/mail/in/ya=
nswers/*http://in.answers.yahoo.com/">Yahoo! Answers</a> </body></html>
--0-737655938-1168989634=:37604--
