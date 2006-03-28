Return-Path: <jcrigby@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.205])
	by ozlabs.org (Postfix) with ESMTP id 3D7CB679EF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Mar 2006 03:15:08 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id s17so1207012wxc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 08:15:07 -0800 (PST)
Message-ID: <4b73d43f0603280815n3fc7bb5dq38b72f87f18b905f@mail.gmail.com>
Date: Tue, 28 Mar 2006 09:15:06 -0700
From: "John Rigby" <jcrigby@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel for MPC Lite 5200 will not compile
In-Reply-To: <20060328094939.GA43123@server.idefix.loc>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_21542_30707012.1143562506763"
References: <20060328000703.GA95672@server.idefix.loc>
	<4b73d43f0603271701q24910d9rf4e61e5136c2b727@mail.gmail.com>
	<20060328094939.GA43123@server.idefix.loc>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_21542_30707012.1143562506763
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sorry I'm not sure what the state of 5200 support in the eldk.  I know that
Wolfgang
has said that 2.6 is not supported though.  You may want to try out Sylvain=
s

kernel:  http://gitbits.246tnt.com/gitbits/linux-2.6-mpc52xx.git

You can search in list for Syvains instructions on how to use it.


On 3/28/06, Matthias Fechner <idefix@fechner.net> wrote:
>
> Hello John,
>
> * John Rigby <jcrigby@gmail.com> [27-03-06 18:01]:
> > try make lite5200_defconfig instead of copying it to .config
> > or make oldconfig after copying ti to .config
>
> I tried now several combinations with:
> make ARCH=3Dppc CROSS_COMPILE=3Dppc_6xx- lite5200_defconfig
> make ARCH=3Dppc CROSS_COMPILE=3Dppc_6xx- uImage
>
> then coping the file to .config and
> make ARCH=3Dppc CROSS_COMPILE=3Dppc_6xx- oldconfig
> make ARCH=3Dppc CROSS_COMPILE=3Dppc_6xx- uImage
>
> but it always leads to the same error message...
>
> Best regards,
> Matthias
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_21542_30707012.1143562506763
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sorry I'm not sure what the state of 5200 support in the eldk.&nbsp; I know=
 that Wolfgang <br>has said that 2.6 is not supported though.&nbsp; You may=
 want to try out Sylvains <br>kernel:&nbsp; <a href=3D"http://gitbits.246tn=
t.com/gitbits/linux-2.6-mpc52xx.git">
http://gitbits.246tnt.com/gitbits/linux-2.6-mpc52xx.git</a><br><br>You can =
search in list for Syvains instructions on how to use it.<br><br><br><div><=
span class=3D"gmail_quote">
On 3/28/06, <b class=3D"gmail_sendername">Matthias Fechner</b> &lt;<a href=
=3D"mailto:idefix@fechner.net" target=3D"_blank" onclick=3D"return top.js.O=
penExtLink(window,event,this)">idefix@fechner.net</a>&gt; wrote:</span><blo=
ckquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204,=
 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

Hello John,<br><br>* John Rigby &lt;<a href=3D"mailto:jcrigby@gmail.com" ta=
rget=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">jc=
rigby@gmail.com</a>&gt; [27-03-06 18:01]:<br>&gt; try make lite5200_defconf=
ig instead of copying it to .config
<br>&gt; or make oldconfig after copying ti to .config
<br><br>I tried now several combinations with:<br>make ARCH=3Dppc CROSS_COM=
PILE=3Dppc_6xx- lite5200_defconfig<br>make ARCH=3Dppc CROSS_COMPILE=3Dppc_6=
xx- uImage<br><br>then coping the file to .config and<br>make ARCH=3Dppc CR=
OSS_COMPILE=3Dppc_6xx- oldconfig
<br>make ARCH=3Dppc CROSS_COMPILE=3Dppc_6xx- uImage<br><br>but it always le=
ads to the same error message...<br><br>Best regards,<br>Matthias<br>______=
_________________________________________<br>Linuxppc-embedded mailing list
<br><a href=3D"mailto:Linuxppc-embedded@ozlabs.org" target=3D"_blank" oncli=
ck=3D"return top.js.OpenExtLink(window,event,this)">Linuxppc-embedded@ozlab=
s.org</a><br><a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedd=
ed" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,thi=
s)">
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote>
</div><br>


------=_Part_21542_30707012.1143562506763--
