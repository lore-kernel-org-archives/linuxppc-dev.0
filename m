Return-Path: <apoorvsangal@gmail.com>
Message-ID: <a79669360510100340g2563b441w9418001c034dbe5b@mail.gmail.com>
Date: Mon, 10 Oct 2005 16:10:30 +0530
From: apoorv sangal <apoorvsangal@gmail.com>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
	Linuxppc-embedded@ozlabs.org, david.jander@protonic.nl
In-Reply-To: <20051007123126.GA6879@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_20833_22641474.1128940830157"
References: <a79669360510062205v629affb9ga687078f018afae@mail.gmail.com>
	<20051007123126.GA6879@cathedrallabs.org>
Cc: apoorv sangal <apoorv_sangal@satyam.com>, vikrant_basotra@satyam.com,
	sibi_mathew@satyam.com
Subject: Re: Problem Regarding Ping in Linux kernel version 2.4.24
Reply-To: apoorv sangal <apoorvsangal@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_20833_22641474.1128940830157
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi
Thanks for the inputs... As per your suggestion I commented
 { mk_mii_write(MII_REG_CR, 0x1200), NULL }, /* autonegotiate */
but it doesn't make any diffrence, still the ping doesn't worked.
 At Boot loader level (u-boot) Ping works fine,
    Regards
Apoorv Sangal


 On 10/7/05, Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org> wrote:
>
> Hi,
> > I have ported Linux kernel version 2.4.24 on MPC8266 based customized
> > Board, having LXT971 ethernet chip.
> > The root file system is JFFS2 which i have made using mkfs.jffs2 utilit=
y
> which
> > comes along with the ELDK 3.0
> > In the kernel code i checked that there is support for the LXT971 chip,
> but
> > even after enabling all the network related funcuntionalities in the
> linux
> > kernel configuration, I am either not able to ping from the board to an=
y
> > machine on the network, nor from the any other machine to the board.
> > The board is able to ping itself.
> > Can some one please throw some light why the board is not able to ping
> any
> > other machine.
> try to comment this line in LXT971 section of driver:
> { mk_mii_write(MII_REG_CR, 0x1200), NULL }, /* autonegotiate */
> and check if it works
>
> --
> Aristeu
>
>

------=_Part_20833_22641474.1128940830157
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi </div>
<div>Thanks for the inputs... As per your suggestion I commented </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;{ mk_m=
ii_write(MII_REG_CR, 0x1200), NULL }, /* autonegotiate */</div>
<div>but it doesn't make any diffrence, still the ping doesn't worked.</div=
>
<div>&nbsp;</div>
<div>At Boot loader level (u-boot) Ping works fine, </div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>
<div>Regards</div><span class=3D"sg">
<div>Apoorv Sangal</div></span></div>
<div>&nbsp;</div>
<div><br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 10/7/05, <b class=3D"gmail_sendername">=
Aristeu Sergio Rozanski Filho</b> &lt;<a href=3D"mailto:aris@cathedrallabs.=
org">aris@cathedrallabs.org</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi,<br>&gt;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I have ported Linux kernel version =
2.4.24 on MPC8266 based customized<br>&gt; Board,&nbsp;&nbsp;having LXT971 =
ethernet chip.
<br>&gt; The root file system is JFFS2 which i have made using mkfs.jffs2 u=
tility which<br>&gt; comes along with the ELDK 3.0<br>&gt; In the kernel co=
de i checked that there is support for the LXT971 chip, but<br>&gt; even af=
ter enabling all the network related funcuntionalities in the linux
<br>&gt; kernel configuration, I am either not able to ping from the board =
to any<br>&gt; machine on the network, nor from the any other machine to th=
e board.<br>&gt; The board is able to ping itself.<br>&gt; Can some one ple=
ase throw some light why the board is not able to ping any
<br>&gt; other machine.<br>try to comment this line in LXT971 section of dr=
iver:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { mk_mii_write(MII_REG_CR, 0x=
1200), NULL }, /* autonegotiate */<br>and check if it works<br><br>--<br>Ar=
isteu<br><br></blockquote>
</div><br>

------=_Part_20833_22641474.1128940830157--
