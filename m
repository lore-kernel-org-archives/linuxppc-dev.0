Return-Path: <sebastien.chretien.enseirb@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.233])
	by ozlabs.org (Postfix) with ESMTP id C644BDDDD8
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Sep 2008 18:44:13 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2383067rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Sep 2008 01:44:11 -0700 (PDT)
Message-ID: <319b0ac50809020144q11ead5f9n12cdbe6dd792a8b7@mail.gmail.com>
Date: Tue, 2 Sep 2008 10:44:11 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: Trace
In-Reply-To: <1220343590.13010.118.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2525_8098992.1220345051759"
References: <319b0ac50809010216jac3ae30r9260699abde6535@mail.gmail.com>
	<319b0ac50809010525w7451ef92m5aaf6fd5f5a8958e@mail.gmail.com>
	<929D3CED81F34E43887A393170D66FB926B40F@GBRSUN01MS002.eu.xerox.net>
	<929D3CED81F34E43887A393170D66FB926B41A@GBRSUN01MS002.eu.xerox.net>
	<48BC195F.4070505@gmail.com> <1220314383.13010.62.camel@pasglop>
	<48BCCB6D.5040209@fr.thalesgroup.com>
	<1220334314.13010.89.camel@pasglop>
	<319b0ac50809020034m12b4d57cj1fdf31f3282935e6@mail.gmail.com>
	<1220343590.13010.118.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_2525_8098992.1220345051759
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

ok. I will try the serial layer

2008/9/2, Benjamin Herrenschmidt <benh@kernel.crashing.org>:
>
> On Tue, 2008-09-02 at 09:34 +0200, S=E9bastien Chr=E9tien wrote:
> > ok is it a bad way to write a tty driver ? why ?
>
>
> Not necessarily, it's just overkill. The UART layer handles a lot
> of stuff for you. The tty layer is tricky to get right.
>
> Cheers,
> Ben.
>
>

------=_Part_2525_8098992.1220345051759
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

ok. I will try the serial layer<br><br><div><span class=3D"gmail_quote">200=
8/9/2, Benjamin Herrenschmidt &lt;<a href=3D"mailto:benh@kernel.crashing.or=
g">benh@kernel.crashing.org</a>&gt;:</span><blockquote class=3D"gmail_quote=
" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0=
.8ex; padding-left: 1ex;">
On Tue, 2008-09-02 at 09:34 +0200, S=E9bastien Chr=E9tien wrote:<br> &gt; o=
k is it a bad way to write a tty driver ? why ?<br> <br> <br>Not necessaril=
y, it&#39;s just overkill. The UART layer handles a lot<br> of stuff for yo=
u. The tty layer is tricky to get right.<br>
 <br> Cheers,<br> Ben.<br> <br> </blockquote></div><br>

------=_Part_2525_8098992.1220345051759--
