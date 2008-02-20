Return-Path: <eric.dujardin@sagem.com>
Received: from mx2.sagem.com (ns2.sagem.com [62.160.59.241])
	by ozlabs.org (Postfix) with ESMTP id DBBB0DDE18
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 19:33:30 +1100 (EST)
To: linuxppc-dev@ozlabs.org
Subject: =?ISO-8859-1?Q?R=E9f=2E_=3A_Status_of_I2C_on_mpc5200?=
Message-ID: <OF5F548B80.FBDDB1C9-ONC12573F5.002E869B-C12573F5.002EFF98@sagem.com>
Date: Wed, 20 Feb 2008 09:33:20 +0100
From: "Eric DUJARDIN" <eric.dujardin@sagem.com>
Content-Type: multipart/alternative;
	boundary="=_alternative 002EFF92C12573F5_="
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=_alternative 002EFF92C12573F5_=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Got it. The mpc52xx's still don't support interrupts i.e. reads require=20
polling.
As a consequence reads may time out.
But it doesn't prevent I2c from working.
Sorry for disturbing,

Eric Dujardin

-------------------------------
Sagem DS - DP Combat Terrestre
178 rue de Paris - F-91344 Massy Cedex
(33) 1 69196792 (direct)
(33) 1 69196904 (fax)
-------------------------------





"Eric DUJARDIN" <eric.dujardin@sagem.com>

Envoy=E9 par : linuxppc-dev-bounces+eric.dujardin=3Dsagem.com@ozlabs.org
19/02/2008 19:00
Remis le : 19/02/2008 19:01

=20
        Pour :=20
        cc :    (ccc : Eric DUJARDIN/DRD/SAGEM)
        Objet : Status of I2C on mpc5200




Hello all,

I have a question regarding the stability of I2C on mpc52xx.
According to menuconfig's help it isn't still stable as it says:
"The driver may also work on 52xx family processors, though interrupts are =

known not to work"

However there has been a patch from Domen Puncer that apparently fixed the =

driver in 2.6.23.
<snip>

If any kind soul could provide a status I'd be glad to provide the patch=20
for the help file...
Thanks,

Eric Dujardin






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
--=_alternative 002EFF92C12573F5_=
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Got it. The mpc52xx's still don't su=
pport interrupts i.e. reads require polling.</font><br><font size=3D2 face=
=3D"sans-serif">As a consequence reads may time out.</font><br><font size=
=3D2 face=3D"sans-serif">But it doesn't prevent I2c from working.</font><br=
><font size=3D2 face=3D"sans-serif">Sorry for disturbing,</font><br><font s=
ize=3D2 face=3D"sans-serif"><br>Eric Dujardin<br><br>----------------------=
---------<br>Sagem DS - DP Combat Terrestre<br>178 rue de Paris - F-91344 M=
assy Cedex<br>(33) 1 69196792 (direct)<br>(33) 1 69196904 (fax)<br>--------=
-----------------------<br></font><br><br><br><table width=3D100%><tr valig=
n=3Dtop><td><td><font size=3D1 face=3D"sans-serif"><b>&quot;Eric DUJARDIN&q=
uot; &lt;eric.dujardin@sagem.com&gt;</b></font><br><br><font size=3D1 face=
=3D"sans-serif">Envoy=E9 par : linuxppc-dev-bounces+eric.dujardin=3Dsagem.c=
om@ozlabs.org</font><p><font size=3D1 face=3D"sans-serif">19/02/2008 19:00<=
/font><br><font size=3D1 face=3D"sans-serif">Remis le : 19/02/2008 19:01</f=
ont><br><td><font size=3D1 face=3D"Arial">&nbsp; &nbsp; &nbsp; &nbsp; </fon=
t><br><font size=3D1 face=3D"sans-serif">&nbsp; &nbsp; &nbsp; &nbsp; Pour :=
 &nbsp; &nbsp; &nbsp; &nbsp;</font><br><font size=3D1 face=3D"sans-serif">&=
nbsp; &nbsp; &nbsp; &nbsp; cc : &nbsp; &nbsp; &nbsp; &nbsp;(ccc : Eric DUJA=
RDIN/DRD/SAGEM)</font><br><font size=3D1 face=3D"sans-serif">&nbsp; &nbsp; =
&nbsp; &nbsp; Objet : &nbsp; &nbsp; &nbsp; &nbsp;Status of I2C on mpc5200</=
font><br></table><br><br><br><font size=3D2 face=3D"sans-serif"><br>Hello a=
ll,</font><font size=3D3 face=3D"Times New Roman"><br></font><font size=3D2=
 face=3D"sans-serif"><br>I have a question regarding the stability of I2C o=
n mpc52xx.<br>According to menuconfig's help it isn't still stable as it sa=
ys:<br>&quot;The driver may also work on 52xx family processors, though int=
errupts are known not to work&quot;</font><font size=3D3 face=3D"Times New =
Roman"><br></font><font size=3D2 face=3D"sans-serif"><br>However there has =
been a patch from Domen Puncer that apparently fixed the driver in 2.6.23.<=
/font><font size=3D3 face=3D"Times New Roman"><br></font><font size=3D2 fac=
e=3D"Courier New">&lt;snip&gt;<br></font><font size=3D2 face=3D"sans-serif"=
><br>If any kind soul could provide a status I'd be glad to provide the pat=
ch for the help file...<br>Thanks,</font><font size=3D3 face=3D"Times New R=
oman"><br></font><font size=3D2 face=3D"sans-serif"><br>Eric Dujardin</font=
><font size=3D3 face=3D"Times New Roman"><br><br></font><br><br><BR>
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
--=_alternative 002EFF92C12573F5_=--
