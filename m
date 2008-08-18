Return-Path: <sebastien.chretien.enseirb@gmail.com>
Message-ID: <319b0ac50808180717ka6731fdu591798ac0d8b4e82@mail.gmail.com>
Date: Mon, 18 Aug 2008 16:17:58 +0200
From: "=?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
To: michael@ellerman.id.au
Subject: Re: [MPC7448] machdep_calls
In-Reply-To: <1219062004.7946.5.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3282_23721124.1219069078041"
References: <319b0ac50808180145r44a1b64fhd09c038ce45bb206@mail.gmail.com>
	<1219051624.28339.39.camel@pasglop>
	<319b0ac50808180422r504a012djb971bf80e819a6d2@mail.gmail.com>
	<319b0ac50808180435o4a8e5bebr79f86e17ba2fb9af@mail.gmail.com>
	<1219062004.7946.5.camel@localhost>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_3282_23721124.1219069078041
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The mpc7448hpc2 uses a tsi108-bridge. My board uses an IP on a FPGA.. I rea=
d
the code of mpc7448_hpc2.c.
It uses a ioremap in order to iniatilize the tsi108 registers. But I have
already initialized MMU with my registers in HEAD_32.S. Do I need to use
ioremap in setup_arch() ?




2008/8/18, Michael Ellerman <michael@ellerman.id.au>:
>
> On Mon, 2008-08-18 at 13:35 +0200, S=E9bastien Chr=E9tien wrote:
> > Can somebody explain me the aim of the function  "setup_arch" in the
> > machine_call structure ?
>
>
> Is this MPC7448 anything like an mpc7448hpc2 ?
>
> If so maybe you should start by looking at the code for it in:
>
> arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
>
> Even if it's not related, that will give you some idea of what the
> callbacks are for.
>
> cheers
>
> --
> Michael Ellerman
> OzLabs, IBM Australia Development Lab
>
> wwweb: http://michael.ellerman.id.au
> phone: +61 2 6212 1183 (tie line 70 21183)
>
> We do not inherit the earth from our ancestors,
> we borrow it from our children. - S.M.A.R.T Person
>
>

------=_Part_3282_23721124.1219069078041
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The mpc7448hpc2 uses a tsi108-bridge. My board uses an IP on a FPGA.. I rea=
d the code of mpc7448_hpc2.c.<br>
It uses a ioremap in order to iniatilize the tsi108 registers. But I
have already initialized MMU with my registers in HEAD_32.S. Do I need
to use ioremap in setup_arch() ?<br><br>
<br>
<br>
<br><div><span class=3D"gmail_quote">2008/8/18, Michael Ellerman &lt;<a hre=
f=3D"mailto:michael@ellerman.id.au">michael@ellerman.id.au</a>&gt;:</span><=
blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 2=
04, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Mon, 2008-08-18 at 13:35 +0200, S=E9bastien Chr=E9tien wrote:<br> &gt; C=
an somebody explain me the aim of the function&nbsp;&nbsp;&quot;setup_arch&=
quot; in the<br> &gt; machine_call structure ?<br> <br> <br>Is this MPC7448=
 anything like an mpc7448hpc2 ?<br>
 <br> If so maybe you should start by looking at the code for it in:<br> <b=
r> arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c<br> <br> Even if it&#3=
9;s not related, that will give you some idea of what the<br> callbacks are=
 for.<br>
 <br> cheers<br> <br> --<br> Michael Ellerman<br> OzLabs, IBM Australia Dev=
elopment Lab<br> <br> wwweb: <a href=3D"http://michael.ellerman.id.au">http=
://michael.ellerman.id.au</a><br> phone: +61 2 6212 1183 (tie line 70 21183=
)<br>
 <br> We do not inherit the earth from our ancestors,<br> we borrow it from=
 our children. - S.M.A.R.T Person<br> <br></blockquote></div><br>

------=_Part_3282_23721124.1219069078041--
