Return-Path: <pantelis.antoniou@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.201])
	by ozlabs.org (Postfix) with ESMTP id 11EB368A7C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 10:01:14 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id o1so1493738nzf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 07 Feb 2006 15:01:13 -0800 (PST)
Message-ID: <449c76a00602071501t2138149fj5b26f15c4b1337d6@mail.gmail.com>
Date: Tue, 7 Feb 2006 18:01:12 -0500
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: MPC875 using SCC4 together with both FECs
In-Reply-To: <2b580ad2e66bb31541226d5353babedb@embeddedalley.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3011_17529247.1139353272746"
References: <IUC8X2$BBAE28486C091C5CAA95431276FDABE5@libero.it>
	<2b580ad2e66bb31541226d5353babedb@embeddedalley.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_3011_17529247.1139353272746
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 2/7/06, Dan Malek <dan@embeddedalley.com> wrote:
>
>
> On Feb 7, 2006, at 5:24 PM, dibacco@@inwind..it wrote:
>
> > Someone knows if, in MPC875, SCC4 can be used together with the two
> > FECs? I saw that RXD4(input SCC4) shares the same GPIO with MII-TXD0
> > (output of FEC0).
>
> That's a correct observation, you can't do it.  I don't remember
> and don't have documentation handy, but would it work in
> RMII mode?  Otherwise, you will have to step up to the MPC870.
>
>
>         -- Dan


IIRC it can in RMII mode...

Don't hold me on that however, no manual and no time to look.

Pantelis

------=_Part_3011_17529247.1139353272746
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">On 2/7/06, <b class=3D"gmail_sende=
rname">Dan Malek</b> &lt;<a href=3D"mailto:dan@embeddedalley.com">dan@embed=
dedalley.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
<br>On Feb 7, 2006, at 5:24 PM, dibacco@@inwind..it wrote:<br><br>&gt; Some=
one knows if, in MPC875, SCC4 can be used together with the two<br>&gt; FEC=
s? I saw that RXD4(input SCC4) shares the same GPIO with MII-TXD0<br>&gt; (=
output of FEC0).
<br><br>That's a correct observation, you can't do it.&nbsp;&nbsp;I don't r=
emember<br>and don't have documentation handy, but would it work in<br>RMII=
 mode?&nbsp;&nbsp;Otherwise, you will have to step up to the MPC870.<br><br=
><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-- Dan
</blockquote><div><br>IIRC it can in RMII mode...<br>&nbsp;<br></div>Don't =
hold me on that however, no manual and no time to look.<br><br>Pantelis<br>=
<br></div>

------=_Part_3011_17529247.1139353272746--
