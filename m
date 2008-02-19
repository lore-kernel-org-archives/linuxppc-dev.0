Return-Path: <eric.dujardin@sagem.com>
Received: from mx1.sagem.com (ns1.sagem.com [62.160.59.65])
	by ozlabs.org (Postfix) with ESMTP id BDF49DDF5D
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 03:09:13 +1100 (EST)
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: =?ISO-8859-1?Q?R=E9f=2E_=3A_Re=3A_[PATCH]_fix_2=2E6=2E25-rc2_compilation?=
	=?ISO-8859-1?Q?_with_CONFIG=5FSPI=5FMPC52xx=5FPSC?=
Message-ID: <OFCE33AD23.0B1C3284-ONC12573F4.00566E50-C12573F4.0056C9ED@sagem.com>
Date: Tue, 19 Feb 2008 16:47:57 +0100
From: "Eric DUJARDIN" <eric.dujardin@sagem.com>
Content-Type: multipart/alternative;
	boundary="=_alternative 0056C9EAC12573F4_="
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Rigby John-R61273 <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=_alternative 0056C9EAC12573F4_=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

OK great.
Additionnally, the FIFO=5F52xx macro probably belongs to mpc52xx=5Fpsc.h.

Eric Dujardin

-------------------------------
Sagem DS - DP Combat Terrestre
178 rue de Paris - F-91344 Massy Cedex
(33) 1 69196792 (direct)
(33) 1 69196904 (fax)
-------------------------------





"Grant Likely" <grant.likely@secretlab.ca>

Envoy=E9 par : linuxppc-dev-bounces+eric.dujardin=3Dsagem.com@ozlabs.org
19/02/2008 16:09
Remis le : 19/02/2008 16:09

=20
        Pour :  EricDuj <eric.dujardin@sagem.com>
        cc :    linuxppc-dev@ozlabs.org, Rigby John-R61273 <jrigby@freescal=
e.com>
        Objet : Re: [PATCH] fix 2.6.25-rc2 compilation with CONFIG=5FSPI=5F=
MPC52xx=5FPSC



On Feb 19, 2008 7:46 AM, EricDuj <eric.dujardin@sagem.com> wrote:
<snip>

Yes, your right.  There were changes made to the psc structures to
support the 5121 but as you've discovered they didn't get propagated
to the spi driver.  Your patch is close, but I need to look at it a
bit deeper today to decide if it is the correct fix.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev





" Ce courriel et les documents qui y sont attaches peuvent contenir des inf=
ormations confidentielles. Si vous n'etes  pas le destinataire escompte, me=
rci d'en informer l'expediteur immediatement et de detruire ce courriel  ai=
nsi que tous les documents attaches de votre systeme informatique. Toute di=
vulgation, distribution ou copie du present courriel et des documents attac=
hes sans autorisation prealable de son emetteur est interdite."=20

" This e-mail and any attached documents may contain confidential or propri=
etary information. If you are not the intended recipient, please advise the=
 sender immediately and delete this e-mail and all attached documents from =
your computer system. Any unauthorised disclosure, distribution or copying =
hereof is prohibited."
--=_alternative 0056C9EAC12573F4_=
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">OK great.</font><br><font size=3D2 f=
ace=3D"sans-serif">Additionnally, the </font><font size=3D3 face=3D"Times N=
ew Roman">FIFO=5F52xx</font><font size=3D2 face=3D"sans-serif"> macro proba=
bly belongs to mpc52xx=5Fpsc.h.</font><br><font size=3D2 face=3D"sans-serif=
"><br>Eric Dujardin<br><br>-------------------------------<br>Sagem DS - DP=
 Combat Terrestre<br>178 rue de Paris - F-91344 Massy Cedex<br>(33) 1 69196=
792 (direct)<br>(33) 1 69196904 (fax)<br>-------------------------------<br=
></font><br><br><br><table width=3D100%><tr valign=3Dtop><td><td><font size=
=3D1 face=3D"sans-serif"><b>&quot;Grant Likely&quot; &lt;grant.likely@secre=
tlab.ca&gt;</b></font><br><br><font size=3D1 face=3D"sans-serif">Envoy=E9 p=
ar : linuxppc-dev-bounces+eric.dujardin=3Dsagem.com@ozlabs.org</font><p><fo=
nt size=3D1 face=3D"sans-serif">19/02/2008 16:09</font><br><font size=3D1 f=
ace=3D"sans-serif">Remis le : 19/02/2008 16:09</font><br><td><font size=3D1=
 face=3D"Arial">&nbsp; &nbsp; &nbsp; &nbsp; </font><br><font size=3D1 face=
=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Pour : &nbsp; &nbsp; &nbsp; &nb=
sp;EricDuj &lt;eric.dujardin@sagem.com&gt;</font><br><font size=3D1 face=3D=
"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; cc : &nbsp; &nbsp; &nbsp; &nbsp;li=
nuxppc-dev@ozlabs.org, Rigby John-R61273 &lt;jrigby@freescale.com&gt;</font=
><br><font size=3D1 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Objet :=
 &nbsp; &nbsp; &nbsp; &nbsp;Re: [PATCH] fix 2.6.25-rc2 compilation with CON=
FIG=5FSPI=5FMPC52xx=5FPSC</font><br></table><br><br><br><font size=3D2 face=
=3D"Courier New">On Feb 19, 2008 7:46 AM, EricDuj &lt;eric.dujardin@sagem.c=
om&gt; wrote:<br>&lt;snip&gt;<br><br>Yes, your right. &nbsp;There were chan=
ges made to the psc structures to<br>support the 5121 but as you've discove=
red they didn't get propagated<br>to the spi driver. &nbsp;Your patch is cl=
ose, but I need to look at it a<br>bit deeper today to decide if it is the =
correct fix.<br><br>Cheers,<br>g.<br><br>-- <br>Grant Likely, B.Sc., P.Eng.=
<br>Secret Lab Technologies Ltd.<br>=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F<br>Linuxppc-dev mailing list<br>Linuxppc-dev@oz=
labs.org<br>https://ozlabs.org/mailman/listinfo/linuxppc-dev<br></font><br>=
<br><BR>
<BR>
&quot; Ce courriel et les documents qui y sont attaches peuvent contenir de=
s informations confidentielles. Si vous n'etes  pas le destinataire escompt=
e, merci d'en informer l'expediteur immediatement et de detruire ce courrie=
l  ainsi que tous les documents attaches de votre systeme informatique. Tou=
te divulgation, distribution ou copie du present courriel et des documents =
attaches sans autorisation prealable de son emetteur est interdite.&quot; <=
BR>
<BR>
&quot; This e-mail and any attached documents may contain confidential or p=
roprietary information. If you are not the intended recipient, please advis=
e the sender immediately and delete this e-mail and all attached documents =
from your computer system. Any unauthorised disclosure, distribution or cop=
ying hereof is prohibited.&quot;<BR>
--=_alternative 0056C9EAC12573F4_=--
