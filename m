Return-Path: <lada.podivin@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E9929B70C3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 22:56:36 +1000 (EST)
Received: from mail-bw0-f208.google.com (mail-bw0-f208.google.com
	[209.85.218.208]) by ozlabs.org (Postfix) with ESMTP id A46EBDDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 22:56:35 +1000 (EST)
Received: by bwz4 with SMTP id 4so899952bwz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Jul 2009 05:56:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e35801cc0907010424l66a7c4dem6f3f363c3b194ff4@mail.gmail.com>
References: <e35801cc0906300658q45d5ea00ub939ba73185efd72@mail.gmail.com>
	<COL107-W41E84129BE81739BC96295B22E0@phx.gbl>
	<e35801cc0907010424l66a7c4dem6f3f363c3b194ff4@mail.gmail.com>
Date: Wed, 1 Jul 2009 14:56:30 +0200
Message-ID: <e35801cc0907010556v1cdb5331g673f7bd3232d9a68@mail.gmail.com>
Subject: Re: ppc405ex + gigabit ethernet
From: Lada Podivin <lada.podivin@gmail.com>
To: LiuMing <eemingliu@hotmail.com>
Content-Type: multipart/alternative; boundary=00163646be02b750bd046da473d3
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00163646be02b750bd046da473d3
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

Eh! I mean Mb/s NOT Kb/s! Sorry!

2009/7/1 Lada Podivin <lada.podivin@gmail.com>

> Thank you for your reply!
> Yes, I agree the CPU is the bottleneck. But I have performed more tests
> with the netperf tool and results seem strange to me. If I send 800 B of
> data, the resulting speed is aproximately 100 Kb/s. On the other hand, If=
 I
> try to send 32KB chunk of data with jumbo frames turned on, resulting spe=
ed
> is about 600 Kb/s (300-400 without jumbo frames). My ppc405ex runs at 600
> MHz.
>
> So it seems that it is definetely better idea to call sendto() less
> frequently with bigger amounts of data, than to call it more often with
> smaler amounts. Is it because smaller data means more frequent user
> space/kernel space switching? Or is it network related issue?
>
> Thanks!
>
> Best,
> Lada
>
> 2009/7/1 LiuMing <eemingliu@hotmail.com>
>
>  Hi,
>> According to our experience on PPC405 + Gigabit Enet, your result is
>> already very reasonable. For UDP transmission, it can be around 400 Kb/s
>> because of the CPU bottleneck (in our case 300 MHz ppc405). If you want
>> to further improve it, a faster CPU is needed to process the TCP/IP stac=
k,
>> or you may buy commercial TCP/IP stack rather than using the free Linux =
one.
>>
>>
>> BR
>> Ming
>>
>> ------------------------------
>> Date: Tue, 30 Jun 2009 15:58:53 +0200
>> Subject: ppc405ex + gigabit ethernet
>> From: lada.podivin@gmail.com
>> To: linuxppc-dev@ozlabs.org
>>
>>
>> Hi,
>>
>> I benchmarked performance of my network, which contains ppc405EX (Kilaue=
a
>> board, kernel 2.6.30 from Denx) connected with a linux desktop via gigab=
it
>> ethernet. I used the netperf tool:
>>
>> netperf -t UDP_STREAM -H 192.168.1.1 -- -m 32768
>>
>> So I was sending UDP packets to the desktop. The resulting speed was abo=
ut
>> 370 Kb/s. I tried to send the packets to several different computers - w=
ith
>> the same result. So the ppc board is the bottleneck in this case.
>>
>> Is there any possibility to improve the gigabit capabilities of the
>> ppc405EX? Is there anyone who achieved a better performance with ppc4xx
>> boards?
>>
>> Thanks!
>>
>> Best,
>> Lada Podivin
>>
>>
>> ------------------------------
>> =C1=A2=BF=CC=CF=C2=D4=D8 MSN =B1=A3=BB=A4=B6=DC=A3=AC=B1=A3=D5=CF MSN =
=B0=B2=C8=AB=CE=C8=B6=A8=A3=A1 =CF=D6=D4=DA=BE=CD=CF=C2=D4=D8=A3=A1 <http:/=
/im.live.cn/safe/>
>>
>
>

--00163646be02b750bd046da473d3
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

Eh! I mean Mb/s NOT Kb/s! Sorry!<br><br><div class=3D"gmail_quote">2009/7/1=
 Lada Podivin <span dir=3D"ltr">&lt;<a href=3D"mailto:lada.podivin@gmail.co=
m">lada.podivin@gmail.com</a>&gt;</span><br><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">
Thank you for your reply!<br>Yes, I agree the CPU is the bottleneck. But I =
have performed more tests with the netperf tool and results seem strange to=
 me. If I send 800 B of data, the resulting speed is aproximately 100 Kb/s.=
 On the other hand, If I try to send 32KB chunk of data with jumbo frames t=
urned on, resulting speed is about 600 Kb/s (300-400 without jumbo frames).=
 My ppc405ex runs at 600 MHz.<br>

<br>So it seems that it is definetely better idea to call sendto() less fre=
quently with bigger amounts of data, than to call it more often with smaler=
 amounts. Is it because smaller data means more frequent user space/kernel =
space switching? Or is it network related issue?&nbsp; <br>

<br>Thanks!<br><br>Best,<br>Lada<br><br><div class=3D"gmail_quote">2009/7/1=
 LiuMing <span dir=3D"ltr">&lt;<a href=3D"mailto:eemingliu@hotmail.com" tar=
get=3D"_blank">eemingliu@hotmail.com</a>&gt;</span><div><div></div><div cla=
ss=3D"h5">
<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">




<div>
Hi,<br>
According to our experience on PPC405 + Gigabit Enet, your result is alread=
y very reasonable. For UDP transmission, it can be around 400 Kb/s because =
of the&nbsp;CPU bottleneck (in our case 300 MHz ppc405). If you want to&nbs=
p;further improve it, a faster CPU is needed to process the TCP/IP stack, o=
r you may buy&nbsp;commercial TCP/IP stack&nbsp;rather than using the free =
Linux one. <br>


&nbsp;<br>
BR<br>
Ming<br>&nbsp;<br>
<hr>
Date: Tue, 30 Jun 2009 15:58:53 +0200<br>Subject: ppc405ex + gigabit ethern=
et<br>From: <a href=3D"mailto:lada.podivin@gmail.com" target=3D"_blank">lad=
a.podivin@gmail.com</a><br>To: <a href=3D"mailto:linuxppc-dev@ozlabs.org" t=
arget=3D"_blank">linuxppc-dev@ozlabs.org</a><div>

<div></div><div><br><br>Hi,<br><br>I benchmarked performance of my network,=
 which contains ppc405EX (Kilauea board, kernel 2.6.30 from Denx) connected=
 with a linux desktop via gigabit ethernet. I used the netperf tool: <br>

<br>netperf -t UDP_STREAM -H 192.168.1.1 -- -m 32768<br><br>So I was sendin=
g UDP packets to the desktop. The resulting speed was about 370 Kb/s. I tri=
ed to send the packets to several different computers - with the same resul=
t. So the ppc board is the bottleneck in this case.<br>

<br>Is there any possibility to improve the gigabit capabilities of the ppc=
405EX? Is there anyone who achieved a better performance with ppc4xx boards=
?<br><br>Thanks!<br><br>Best,<br>Lada Podivin<br><br><br></div></div><div>

<hr>=C1=A2=BF=CC=CF=C2=D4=D8 MSN =B1=A3=BB=A4=B6=DC=A3=AC=B1=A3=D5=CF MSN =
=B0=B2=C8=AB=CE=C8=B6=A8=A3=A1 <a href=3D"http://im.live.cn/safe/" target=
=3D"_blank">=CF=D6=D4=DA=BE=CD=CF=C2=D4=D8=A3=A1</a></div></div>
</blockquote></div></div></div><br>
</blockquote></div><br>

--00163646be02b750bd046da473d3--
