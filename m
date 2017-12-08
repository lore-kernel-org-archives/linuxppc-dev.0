Return-Path: <sascha.schroeder@aethyx.com>
Date: Fri, 08 Dec 2017 21:43:46 +0100
In-Reply-To: <1dd3a437-a20e-c808-749c-4cdb7b9d3675@infradead.org>
References: <9621b73a-12e0-1254-932c-2456238b5526@aethyx.com>
 <1dd3a437-a20e-c808-749c-4cdb7b9d3675@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----7PO4X9U4TW4RXBXEG6V66U612WFGFM"
Subject: Re: Getting kernel 4.14 to run on PS3
To: Geoff Levand <geoff@infradead.org>
CC: Linuxppc-dev@lists.ozlabs.org,petitboot@lists.ozlabs.org
From: Sascha Schroeder <sascha.schroeder@aethyx.com>
Message-ID: <C14897C2-E09E-4409-AA28-E76547CECD04@aethyx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------7PO4X9U4TW4RXBXEG6V66U612WFGFM
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Geoff,

thanks for your time and the clarification!

My firmware is downgradable, this should be possible because it got SS pat=
ches=2E Could be these are from you, so I could go back in fact to 3=2E15 a=
nd try the otheros=2Ebld workaround=2E Thing is, I don't know if I can spli=
t my HDD to use my 110GB Linux; isn't it the case that normal OtherOS only =
grants you 20GB for Linux? That's the only thing that's holding me back, th=
is way I could even use normal Debian=2E

I use an old and still working FAT model=2E The 1400 is a tool model which=
 I don't own=2E

I don't like what I read about the ABI breakage stuff, to be honest=2E Esp=
ecially the second link describes pretty well what happens on my machine=2E=
 So, current status here is to upgrade to 3=2E15 kernels only, I think it d=
oesn't make sense to try higher versions at the moment=2E Is it really "onl=
y" a kexec problem? Or something deeper, more difficult? I can try to help =
but I'm pretty new in this PS3 PowerPC Linux stuff=2E=20

Using OtherOS++ was a coincidence=2E I found this special PUP which splits=
 the HDD in half for Linux and GameOS=2E This was exactly what I wanted, so=
 I stuck with it=2E :-) Finding PUPs today which provide Linux options is n=
early impossible=2E I'm not a fan of "Rebug" either, don't want/need it=2E =
But they had one firmware with OtherOS++ support which was taken down or wh=
atever=2E It's just non-existent anymore=2E

You don't know a community for OtherOS++ by chance? I found some forums on=
line but most of them only care about pirated games (which doesn't interest=
 me at this age anymore) and/or show posts which are highly outdated=2E

It's pretty hard today to stick with this hardware=2E But I'm fascinated b=
y the Cell BE and want to learn it=2E It became a little obsession=2E So ev=
en compiling a kernel on the PS3 doesn't bother me much, I go to work and w=
hen I come home the fresh *=2Edeb packages are ready to install=2E :-D But =
I understand what you mean of course, will check out cross-compiling=2E=20

Geoff, thanks again for your time and wisdom! All the best, Sascha

Am 8=2E Dezember 2017 18:37:54 MEZ schrieb Geoff Levand <geoff@infradead=
=2Eorg>:
>Hi Sascha,
>
>On 12/08/2017 01:24 AM, Sascha Schroeder wrote:
>> I yesterday tried to compile the newest kernel 4=2E14 for my PS3
>running
>> OtherOS++ and "Red Ribbon GNU Linux" from 2014=2E I even succeeded and
>> created the three *=2Edeb files and installed them afterwards=2E
>>=20
>> Unfortunately, my machine did not boot=2E
>>=20
>> As far as I read in very old sources, this could be that my machine
>is
>> using OtherOS++ on firmware 3=2E55=2E2 and not the Sony OtherOS prior
>> firmware 3=2E2x=2E
>>=20
>> I'm in contact with the creator from "Red Ribbon" and he mentioned we
>> have to manually patch PS3 linux kernel=2E
>>=20
>> So, my question 1 would be: which patches would I need to get the
>newest
>> kernel 4=2E14 running on my PS3 machine?
>
>I don't know about your machine with OtherOS++ on firmware 3=2E55=2E2,
>but for FAT and DECR-1400 models with firmware 3=2E15 or lower the
>otheros=2Ebld built from the latest ps3-queue-v4=2E14 branch of my
>ps3-linux repo using either ps3_petitboot_defconfig or
>ps3_petitboot_nfs_defconfig will boot if written to flash memory
>using ps3-flash-util or the XMB [Install Other OS]=2E
>
>  https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/geoff/ps3-linux=2Eg=
it
>
>Be aware that there was a kernel ABI breakage effecting kexec and
>that the ps3-petitboot-09=2E11=2E30 I released cannot boot kernels newer
>than linux-v3=2E15=2E See:
>
>https://www=2Email-archive=2Ecom/linuxppc-dev@lists=2Eozlabs=2Eorg/msg126=
348=2Ehtml
>(Boot new kernel on PS3)
>https://www=2Email-archive=2Ecom/debian-powerpc@lists=2Edebian=2Eorg/msg6=
6884=2Ehtml
>(PS3?)
>
>I'm working towards an updated petitboot release=2E
>
>> Question 2 would be: maybe there exists a second tree where we can
>get
>> the kernel for OtherOS++ too?
>
>Sorry, I don't know=2E  You'll need to ask for help in the hacker
>community for OtherOS++=2E
>
>> Maybe there is other stuff I am missing, but as far as I can tell the
>> sources compile beautifully on the PS3 powerpc machine=2E Only
>downside:
>> it takes 4-5 hours depending on what you selected in the step of
>"make
>> menuconfig"=2E=2E=2E
>
>I highly recommend you cross compile on a PC=2E
>
>-Geoff=20

------7PO4X9U4TW4RXBXEG6V66U612WFGFM
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>Hey Geoff,<br>
<br>
thanks for your time and the clarification!<br>
<br>
My firmware is downgradable, this should be possible because it got SS pat=
ches=2E Could be these are from you, so I could go back in fact to 3=2E15 a=
nd try the otheros=2Ebld workaround=2E Thing is, I don&#39;t know if I can =
split my HDD to use my 110GB Linux; isn&#39;t it the case that normal Other=
OS only grants you 20GB for Linux? That&#39;s the only thing that&#39;s hol=
ding me back, this way I could even use normal Debian=2E<br>
<br>
I use an old and still working FAT model=2E The 1400 is a tool model which=
 I don&#39;t own=2E<br>
<br>
I don&#39;t like what I read about the ABI breakage stuff, to be honest=2E=
 Especially the second link describes pretty well what happens on my machin=
e=2E So, current status here is to upgrade to 3=2E15 kernels only, I think =
it doesn&#39;t make sense to try higher versions at the moment=2E Is it rea=
lly &quot;only&quot; a kexec problem? Or something deeper, more difficult? =
I can try to help but I&#39;m pretty new in this PS3 PowerPC Linux stuff=2E=
 <br>
<br>
Using OtherOS++ was a coincidence=2E I found this special PUP which splits=
 the HDD in half for Linux and GameOS=2E This was exactly what I wanted, so=
 I stuck with it=2E :-) Finding PUPs today which provide Linux options is n=
early impossible=2E I&#39;m not a fan of &quot;Rebug&quot; either, don&#39;=
t want/need it=2E But they had one firmware with OtherOS++ support which wa=
s taken down or whatever=2E It&#39;s just non-existent anymore=2E<br>
<br>
You don&#39;t know a community for OtherOS++ by chance? I found some forum=
s online but most of them only care about pirated games (which doesn&#39;t =
interest me at this age anymore) and/or show posts which are highly outdate=
d=2E<br>
<br>
It&#39;s pretty hard today to stick with this hardware=2E But I&#39;m fasc=
inated by the Cell BE and want to learn it=2E It became a little obsession=
=2E So even compiling a kernel on the PS3 doesn&#39;t bother me much, I go =
to work and when I come home the fresh *=2Edeb packages are ready to instal=
l=2E :-D But I understand what you mean of course, will check out cross-com=
piling=2E <br>
<br>
Geoff, thanks again for your time and wisdom! All the best, Sascha<br><br>=
<div class=3D"gmail_quote">Am 8=2E Dezember 2017 18:37:54 MEZ schrieb Geoff=
 Levand &lt;geoff@infradead=2Eorg&gt;:<blockquote class=3D"gmail_quote" sty=
le=3D"margin: 0pt 0pt 0pt 0=2E8ex; border-left: 1px solid rgb(204, 204, 204=
); padding-left: 1ex;">
<pre class=3D"k9mail">Hi Sascha,<br /><br />On 12/08/2017 01:24 AM, Sascha=
 Schroeder wrote:<br /><blockquote class=3D"gmail_quote" style=3D"margin: 0=
pt 0pt 1ex 0=2E8ex; border-left: 1px solid #729fcf; padding-left: 1ex;"> I =
yesterday tried to compile the newest kernel 4=2E14 for my PS3 running<br /=
> OtherOS++ and &quot;Red Ribbon GNU Linux&quot; from 2014=2E I even succee=
ded and<br /> created the three *=2Edeb files and installed them afterwards=
=2E<br /> <br /> Unfortunately, my machine did not boot=2E<br /> <br /> As =
far as I read in very old sources, this could be that my machine is<br /> u=
sing OtherOS++ on firmware 3=2E55=2E2 and not the Sony OtherOS prior<br /> =
firmware 3=2E2x=2E<br /> <br /> I'm in contact with the creator from &quot;=
Red Ribbon&quot; and he mentioned we<br /> have to manually patch PS3 linux=
 kernel=2E<br /> <br /> So, my question 1 would be: which patches would I n=
eed to get the newest<br /> kernel 4=2E14 running on my PS3 machine?<br /><=
/blockquote><br />I don't know about your machine with OtherOS++ on firmwar=
e 3=2E55=2E2,<br />but for FAT and DECR-1400 models with firmware 3=2E15 or=
 lower the<br />otheros=2Ebld built from the latest ps3-queue-v4=2E14 branc=
h of my<br />ps3-linux repo using either ps3_petitboot_defconfig or<br />ps=
3_petitboot_nfs_defconfig will boot if written to flash memory<br />using p=
s3-flash-util or the XMB [Install Other OS]=2E<br /><br />  <a href=3D"http=
s://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/geoff/ps3-linux=2Egit">http=
s://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/geoff/ps3-linux=2Egit</a><b=
r /><br />Be aware that there was a kernel ABI breakage effecting kexec and=
<br />that the ps3-petitboot-09=2E11=2E30 I released cannot boot kernels ne=
wer<br />than linux-v3=2E15=2E See:<br /><br />  <a href=3D"https://www=2Em=
ail-archive=2Ecom/linuxppc-dev@lists=2Eozlabs=2Eorg/msg126348=2Ehtml">https=
://www=2Email-archive=2Ecom/linuxppc-dev@lists=2Eozlabs=2Eorg/msg126348=2Eh=
tml</a> (Boot new kernel on PS3)<br />  <a href=3D"https://www=2Email-archi=
ve=2Ecom/debian-powerpc@lists=2Edebian=2Eorg/msg66884=2Ehtml">https://www=
=2Email-archive=2Ecom/debian-powerpc@lists=2Edebian=2Eorg/msg66884=2Ehtml</=
a> (PS3?)<br /><br />I'm working towards an updated petitboot release=2E<br=
 /><br /><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 1ex 0=
=2E8ex; border-left: 1px solid #729fcf; padding-left: 1ex;"> Question 2 wou=
ld be: maybe there exists a second tree where we can get<br /> the kernel f=
or OtherOS++ too?<br /></blockquote><br />Sorry, I don't know=2E  You'll ne=
ed to ask for help in the hacker<br />community for OtherOS++=2E<br /><br /=
><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 1ex 0=2E8ex; bo=
rder-left: 1px solid #729fcf; padding-left: 1ex;"> Maybe there is other stu=
ff I am missing, but as far as I can tell the<br /> sources compile beautif=
ully on the PS3 powerpc machine=2E Only downside:<br /> it takes 4-5 hours =
depending on what you selected in the step of &quot;make<br /> menuconfig&q=
uot;=2E=2E=2E<br /></blockquote><br />I highly recommend you cross compile =
on a PC=2E<br /><br />-Geoff <br /></pre></blockquote></div></body></html>
------7PO4X9U4TW4RXBXEG6V66U612WFGFM--
