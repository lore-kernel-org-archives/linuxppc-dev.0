Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.229])
	by ozlabs.org (Postfix) with ESMTP id 33E5ADDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Sep 2008 17:34:41 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2360210rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Sep 2008 00:34:39 -0700 (PDT)
Message-ID: <319b0ac50809020034m12b4d57cj1fdf31f3282935e6@mail.gmail.com>
Date: Tue, 2 Sep 2008 09:34:39 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: Trace
In-Reply-To: <1220334314.13010.89.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2049_22361501.1220340879409"
References: <319b0ac50809010216jac3ae30r9260699abde6535@mail.gmail.com>
	<929D3CED81F34E43887A393170D66FB926B259@GBRSUN01MS002.eu.xerox.net>
	<319b0ac50809010525w7451ef92m5aaf6fd5f5a8958e@mail.gmail.com>
	<929D3CED81F34E43887A393170D66FB926B40F@GBRSUN01MS002.eu.xerox.net>
	<929D3CED81F34E43887A393170D66FB926B41A@GBRSUN01MS002.eu.xerox.net>
	<48BC195F.4070505@gmail.com> <1220314383.13010.62.camel@pasglop>
	<48BCCB6D.5040209@fr.thalesgroup.com>
	<1220334314.13010.89.camel@pasglop>
Cc: =?ISO-8859-1?Q?S=E9bastien_CHRETIEN?=
	<sebastien.chretien@fr.thalesgroup.com>, linuxppc-dev@ozlabs.org,
	"Jenkins, Clive" <Clive.Jenkins@xerox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_2049_22361501.1220340879409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

ok is it a bad way to write a tty driver ? why ?

2008/9/2, Benjamin Herrenschmidt <benh@kernel.crashing.org>:
>
> On Tue, 2008-09-02 at 07:13 +0200, S=E9bastien CHRETIEN wrote:
> > My board has only a uart device on a FPGA. I don't use the serial layer
> > because it isn't documented in Linux Device Driver 3rd. Only the tty
> > layer is documented
>
>
> You won't go very far in linux kernel dev. with using books like
> that :-)
>
> Look at other drivers in drivers/serial that should give you all the
> information you need :-0
>
> Cheers,
> Ben.
>
>
>

------=_Part_2049_22361501.1220340879409
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

ok is it a bad way to write a tty driver ? why ?<br><br><div><span class=3D=
"gmail_quote">2008/9/2, Benjamin Herrenschmidt &lt;<a href=3D"mailto:benh@k=
ernel.crashing.org">benh@kernel.crashing.org</a>&gt;:</span><blockquote cla=
ss=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); marg=
in: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Tue, 2008-09-02 at 07:13 +0200, S=E9bastien CHRETIEN wrote:<br> &gt; My =
board has only a uart device on a FPGA. I don&#39;t use the serial layer<br=
> &gt; because it isn&#39;t documented in Linux Device Driver 3rd. Only the=
 tty<br>
 &gt; layer is documented<br> <br> <br>You won&#39;t go very far in linux k=
ernel dev. with using books like<br> that :-)<br> <br> Look at other driver=
s in drivers/serial that should give you all the<br> information you need :=
-0<br>
 <br> Cheers,<br> Ben.<br> <br> <br> </blockquote></div><br>

------=_Part_2049_22361501.1220340879409--
