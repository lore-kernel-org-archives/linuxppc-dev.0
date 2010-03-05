Return-Path: <vijay.t.nikam@gmail.com>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) by ozlabs.org (Postfix) with ESMTP id 56A8AB7CE4
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Mar 2010 21:06:02 +1100 (EST)
Received: by pwi10 with SMTP id 10so2269832pwi.15
	for <linuxppc-dev@ozlabs.org>; Fri, 05 Mar 2010 02:06:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <248783.45498.qm@web83507.mail.sp1.yahoo.com>
References: <248783.45498.qm@web83507.mail.sp1.yahoo.com>
Date: Fri, 5 Mar 2010 15:36:00 +0530
Message-ID: <f234e2141003050206p7b945f8flfac60914b9239772@mail.gmail.com>
Subject: Re: JFFS2 warnings
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: Ron Madrid <ron_madrid@sbcglobal.net>
Content-Type: multipart/alternative; boundary=0016367f925fca480904810adc5b
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016367f925fca480904810adc5b
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I too facing the same problems. I too have mpc8313 based customized board.
Would you please let me know, if you know how to resolve these messages.

Kindly please acknowledge, thank you

Kind Regards,
Vijay Nikam

On Tue, Mar 2, 2010 at 12:13 AM, Ron Madrid <ron_madrid@sbcglobal.net>wrote:

> I'm getting a bunch of these after I 'reboot' or 'poweroff'
> several times.
>
> Empty flash at 0x0056205c ends at 0x00562800
> Empty flash at 0x00565334 ends at 0x00565800
> Empty flash at 0x00576104 ends at 0x00576800
>
> JFFS2 notice: (848) check_node_data: wrong data CRC
> in data node at 0x00577034: read 0xe6adad18, calculated
> 0x202a305c.
> JFFS2 notice: (848) check_node_data: wrong data CRC
> in data node at 0x00575768: read 0xe6adad18, calculated
> 0xfc64f8a3.
>
> I'm not too sure why I'm getting these, but recently
> they seem to have caused a few problems with parts of
> my filesystem (i.e. programs not running correctly).
>
> Can someone tell me what these are or what could be
> causing them?
>
> I'm using 2.6.33rc1 and this is on an mpc8313 based board.
> Not sure what other info would be useful.
>
> Thanks,
>
> Ron
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

--0016367f925fca480904810adc5b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hello,</div>
<div>=A0</div>
<div>I too facing the same problems. I too have mpc8313 based customized bo=
ard. </div>
<div>Would you please let me know, if you know how to resolve these message=
s.</div>
<div>=A0</div>
<div>Kindly please acknowledge, thank you</div>
<div>=A0</div>
<div>Kind Regards,</div>
<div>Vijay Nikam<br><br></div>
<div class=3D"gmail_quote">On Tue, Mar 2, 2010 at 12:13 AM, Ron Madrid <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:ron_madrid@sbcglobal.net">ron_madrid@sb=
cglobal.net</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">I&#39;m getting a bunch of these=
 after I &#39;reboot&#39; or &#39;poweroff&#39;<br>several times.<br><br>Em=
pty flash at 0x0056205c ends at 0x00562800<br>
Empty flash at 0x00565334 ends at 0x00565800<br>Empty flash at 0x00576104 e=
nds at 0x00576800<br><br>JFFS2 notice: (848) check_node_data: wrong data CR=
C<br>in data node at 0x00577034: read 0xe6adad18, calculated<br>0x202a305c.=
<br>
JFFS2 notice: (848) check_node_data: wrong data CRC<br>in data node at 0x00=
575768: read 0xe6adad18, calculated<br>0xfc64f8a3.<br><br>I&#39;m not too s=
ure why I&#39;m getting these, but recently<br>they seem to have caused a f=
ew problems with parts of<br>
my filesystem (i.e. programs not running correctly).<br><br>Can someone tel=
l me what these are or what could be<br>causing them?<br><br>I&#39;m using =
2.6.33rc1 and this is on an mpc8313 based board.<br>Not sure what other inf=
o would be useful.<br>
<br>Thanks,<br><br>Ron<br>_______________________________________________<b=
r>Linuxppc-dev mailing list<br><a href=3D"mailto:Linuxppc-dev@lists.ozlabs.=
org">Linuxppc-dev@lists.ozlabs.org</a><br><a href=3D"https://lists.ozlabs.o=
rg/listinfo/linuxppc-dev" target=3D"_blank">https://lists.ozlabs.org/listin=
fo/linuxppc-dev</a><br>
</blockquote></div><br>

--0016367f925fca480904810adc5b--
