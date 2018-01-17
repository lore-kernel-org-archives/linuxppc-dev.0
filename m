Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLxBK6k8gzF0Xn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 16:54:48 +1100 (AEDT)
Content-Type: multipart/alternative;
 boundary=Apple-Mail-453CD8A2-AA07-434D-8C45-5D5229033B29
Mime-Version: 1.0 (1.0)
Subject: Re: DPAA Ethernet traffice troubles with Linux kernel
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <CAHkrCmFd8F8Bpm8vUete_QHjGosyXH0JZVEJ6gwvBMMUtBivLQ@mail.gmail.com>
Date: Wed, 17 Jan 2018 06:54:34 +0100
Cc: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "andrew@lunn.ch" <andrew@lunn.ch>,
 "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-Id: <98ECD3EA-F121-417E-A004-DE4889D06B11@xenosoft.de>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com> <20180116143836.GC22903@lunn.ch>
 <1516125454.18795.87.camel@infinera.com>
 <CAHkrCmFd8F8Bpm8vUete_QHjGosyXH0JZVEJ6gwvBMMUtBivLQ@mail.gmail.com>
To: mad skateman <madskateman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail-453CD8A2-AA07-434D-8C45-5D5229033B29
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable

FYI

Sent from my iPhone

> On 17. Jan 2018, at 06:50, Christian Zigotzky <chzigotzky@xenosoft.de> wro=
te:
>=20
> Hi Skateman,
>=20
> Fantastic! Many thanks for testing the RC8 of kernel 4.15 without PAMU sup=
port.
>=20
> @All
> Further information: http://forum.hyperion-entertainment.biz/viewtopic.php=
?f=3D58&p=3D43706#p43706
>=20
> Cheers,
> Christian
>=20
> Sent from my iPhone
>=20
>> On 16. Jan 2018, at 23:05, mad skateman <madskateman@gmail.com> wrote:
>>=20
>> Fantastic Christian..=20
>>=20
>> Your latest kernel makes the NIC work!!!
>>=20
>> Few tweaks to be done... like the buffer space=20
>>=20
>> Brilliant!
>=20
>=20
>=20
>> On 16. Jan 2018, at 21:46, Christian Zigotzky <chzigotzky@xenosoft.de> wr=
ote:
>>=20
>> FYI
>>=20
>>> On 16 January 2018 at 9:42PM, Christian Zigotzky wrote:
>>> Hi All,
>>>=20
>>> I compiled the RC8 of kernel 4.15 for the X5000 without PAMU support tod=
ay.
>>>=20
>>> Download: http://www.xenosoft.de/uImage_without_pamu.tar.gz
>>>=20
>>> Please test it on your AmigaOne X5000.
>>>=20
>>> Thanks,
>>> Christian
>>>=20
>>>=20
>>> On 16 January 2018 at 6:33PM, Madalin-cristian Bucur wrote:
>>>>> The PAMU related errors may be relevant to the issue, if you have inco=
rrect
>>>>> settings you may have no traffic passing through. The PAMU configurati=
on
>>>>> should be made by the bootloader. Can you try to disable CONFIG_FSL_PA=
MU?
>>>>>=20
>>>>> Madalin
>>>>>=20
>>>>>=20
>>>=20

--Apple-Mail-453CD8A2-AA07-434D-8C45-5D5229033B29
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><span style=3D"background-color: rgba(255, 2=
55, 255, 0);">FYI<br><br></span><div><span style=3D"background-color: rgba(2=
55, 255, 255, 0);">Sent from my iPhone</span></div><div><span style=3D"backg=
round-color: rgba(255, 255, 255, 0);"><br></span><font color=3D"#000000"><sp=
an style=3D"background-color: rgba(255, 255, 255, 0);">On 17. Jan 2018, at 0=
6:50, Christian Zigotzky &lt;<a href=3D"mailto:chzigotzky@xenosoft.de">chzig=
otzky@xenosoft.de</a>&gt; wrote:<br><br></span></font></div><blockquote type=
=3D"cite"><font color=3D"#000000"><span style=3D"background-color: rgba(255,=
 255, 255, 0);">Hi Skateman,<br><br>Fantastic! Many thanks for testing the R=
C8 of kernel 4.15 without PAMU support.</span></font><div><font color=3D"#00=
0000"><span style=3D"background-color: rgba(255, 255, 255, 0);"><br></span><=
/font></div><div><font color=3D"#000000"><span style=3D"background-color: rg=
ba(255, 255, 255, 0);">@All</span></font></div><div><font color=3D"#000000">=
<span style=3D"background-color: rgba(255, 255, 255, 0);">Further informatio=
n:&nbsp;<a href=3D"http://forum.hyperion-entertainment.biz/viewtopic.php?f=3D=
58&amp;p=3D43706#p43706">http://forum.hyperion-entertainment.biz/viewtopic.p=
hp?f=3D58&amp;p=3D43706#p43706</a><br><br>Cheers,<br>Christian<br><br>Sent f=
rom my iPhone<br><br></span></font><blockquote type=3D"cite"><font color=3D"=
#000000"><span style=3D"background-color: rgba(255, 255, 255, 0);">On 16. Ja=
n 2018, at 23:05, mad skateman &lt;<a href=3D"mailto:madskateman@gmail.com" d=
ir=3D"ltr" x-apple-data-detectors=3D"true" x-apple-data-detectors-type=3D"li=
nk" x-apple-data-detectors-result=3D"1">madskateman@gmail.com</a>&gt; wrote:=
<br></span></font></blockquote><blockquote type=3D"cite"><font color=3D"#000=
000"><span style=3D"background-color: rgba(255, 255, 255, 0);"><br></span></=
font></blockquote><blockquote type=3D"cite"><font color=3D"#000000"><span st=
yle=3D"background-color: rgba(255, 255, 255, 0);">Fantastic Christian..&nbsp=
;<br></span></font></blockquote><blockquote type=3D"cite"><font color=3D"#00=
0000"><span style=3D"background-color: rgba(255, 255, 255, 0);"><br></span><=
/font></blockquote><blockquote type=3D"cite"><font color=3D"#000000"><span s=
tyle=3D"background-color: rgba(255, 255, 255, 0);">Your latest kernel makes t=
he NIC work!!!<br></span></font></blockquote><blockquote type=3D"cite"><font=
 color=3D"#000000"><span style=3D"background-color: rgba(255, 255, 255, 0);"=
><br></span></font></blockquote><blockquote type=3D"cite"><font color=3D"#00=
0000"><span style=3D"background-color: rgba(255, 255, 255, 0);">Few tweaks t=
o be done... like the buffer space&nbsp;<br></span></font></blockquote><bloc=
kquote type=3D"cite"><font color=3D"#000000"><span style=3D"background-color=
: rgba(255, 255, 255, 0);"><br></span></font></blockquote><blockquote type=3D=
"cite"><font color=3D"#000000"><span style=3D"background-color: rgba(255, 25=
5, 255, 0);">Brilliant!</span></font></blockquote><font color=3D"#000000"><s=
pan style=3D"background-color: rgba(255, 255, 255, 0);"><br></span></font><d=
iv><font color=3D"#000000"><span style=3D"background-color: rgba(255, 255, 2=
55, 0);"><br></span></font></div><div><font color=3D"#000000"><span style=3D=
"background-color: rgba(255, 255, 255, 0);"><br></span></font><font color=3D=
"#000000"><span style=3D"background-color: rgba(255, 255, 255, 0);">On 16. J=
an 2018, at 21:46, Christian Zigotzky &lt;<a href=3D"mailto:chzigotzky@xenos=
oft.de">chzigotzky@xenosoft.de</a>&gt; wrote:<br><br></span></font></div><bl=
ockquote type=3D"cite"><font color=3D"#000000"><span style=3D"background-col=
or: rgba(255, 255, 255, 0);">FYI<br><br></span></font><font color=3D"#000000=
"><span style=3D"background-color: rgba(255, 255, 255, 0);">On 16 January 20=
18 at 9:42PM, Christian Zigotzky wrote:<br></span></font><blockquote type=3D=
"cite"><font color=3D"#000000"><span style=3D"background-color: rgba(255, 25=
5, 255, 0);">Hi All,<br></span></font></blockquote><blockquote type=3D"cite"=
><font color=3D"#000000"><span style=3D"background-color: rgba(255, 255, 255=
, 0);"><br></span></font></blockquote><blockquote type=3D"cite"><font color=3D=
"#000000"><span style=3D"background-color: rgba(255, 255, 255, 0);">I compil=
ed the RC8 of kernel 4.15 for the X5000 without PAMU support today.<br></spa=
n></font></blockquote><blockquote type=3D"cite"><font color=3D"#000000"><spa=
n style=3D"background-color: rgba(255, 255, 255, 0);"><br></span></font></bl=
ockquote><blockquote type=3D"cite"><font color=3D"#000000"><span style=3D"ba=
ckground-color: rgba(255, 255, 255, 0);">Download:&nbsp;<a href=3D"http://ww=
w.xenosoft.de/uImage_without_pamu.tar.gz">http://www.xenosoft.de/uImage_with=
out_pamu.tar.gz</a><br></span></font></blockquote><blockquote type=3D"cite">=
<font color=3D"#000000"><span style=3D"background-color: rgba(255, 255, 255,=
 0);"><br></span></font></blockquote><blockquote type=3D"cite"><font color=3D=
"#000000"><span style=3D"background-color: rgba(255, 255, 255, 0);">Please t=
est it on your AmigaOne X5000.<br></span></font></blockquote><blockquote typ=
e=3D"cite"><font color=3D"#000000"><span style=3D"background-color: rgba(255=
, 255, 255, 0);"><br></span></font></blockquote><blockquote type=3D"cite"><f=
ont color=3D"#000000"><span style=3D"background-color: rgba(255, 255, 255, 0=
);">Thanks,<br></span></font></blockquote><blockquote type=3D"cite"><font co=
lor=3D"#000000"><span style=3D"background-color: rgba(255, 255, 255, 0);">Ch=
ristian<br></span></font></blockquote><blockquote type=3D"cite"><font color=3D=
"#000000"><span style=3D"background-color: rgba(255, 255, 255, 0);"><br></sp=
an></font></blockquote><blockquote type=3D"cite"><font color=3D"#000000"><sp=
an style=3D"background-color: rgba(255, 255, 255, 0);"><br></span></font></b=
lockquote><blockquote type=3D"cite"><font color=3D"#000000"><span style=3D"b=
ackground-color: rgba(255, 255, 255, 0);">On 16 January 2018 at 6:33PM, Mada=
lin-cristian Bucur wrote:<br></span></font></blockquote><blockquote type=3D"=
cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><font color=3D"#00=
0000"><span style=3D"background-color: rgba(255, 255, 255, 0);">The PAMU rel=
ated errors may be relevant to the issue, if you have incorrect<br></span></=
font></blockquote></blockquote></blockquote><blockquote type=3D"cite"><block=
quote type=3D"cite"><blockquote type=3D"cite"><font color=3D"#000000"><span s=
tyle=3D"background-color: rgba(255, 255, 255, 0);">settings you may have no t=
raffic passing through. The PAMU configuration<br></span></font></blockquote=
></blockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cit=
e"><blockquote type=3D"cite"><font color=3D"#000000"><span style=3D"backgrou=
nd-color: rgba(255, 255, 255, 0);">should be made by the bootloader. Can you=
 try to disable CONFIG_FSL_PAMU?<br></span></font></blockquote></blockquote>=
</blockquote><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote=
 type=3D"cite"><font color=3D"#000000"><span style=3D"background-color: rgba=
(255, 255, 255, 0);"><br></span></font></blockquote></blockquote></blockquot=
e><blockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"ci=
te"><font color=3D"#000000"><span style=3D"background-color: rgba(255, 255, 2=
55, 0);">Madalin<br></span></font></blockquote></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><=
font color=3D"#000000"><span style=3D"background-color: rgba(255, 255, 255, 0=
);"><br></span></font></blockquote></blockquote></blockquote><blockquote typ=
e=3D"cite"><blockquote type=3D"cite"><blockquote type=3D"cite"><font color=3D=
"#000000"><span style=3D"background-color: rgba(255, 255, 255, 0);"><br></sp=
an></font></blockquote></blockquote></blockquote><blockquote type=3D"cite"><=
br></blockquote></blockquote></div></blockquote></body></html>=

--Apple-Mail-453CD8A2-AA07-434D-8C45-5D5229033B29--
