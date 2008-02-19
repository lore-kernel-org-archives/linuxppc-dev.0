Return-Path: <eric.dujardin@sagem.com>
Received: from mx1.sagem.com (ns1.sagem.com [62.160.59.65])
	by ozlabs.org (Postfix) with ESMTP id CE90EDE0ED
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 05:00:52 +1100 (EST)
To: linuxppc-dev@ozlabs.org
Subject: Status of I2C on mpc5200
Message-ID: <OF3653BBA6.8BF9605E-ONC12573F4.0060C5B5-C12573F4.0062F418@sagem.com>
Date: Tue, 19 Feb 2008 19:00:49 +0100
From: "Eric DUJARDIN" <eric.dujardin@sagem.com>
Content-Type: multipart/alternative;
	boundary="=_alternative 0062F413C12573F4_="
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=_alternative 0062F413C12573F4_=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all,

I have a question regarding the stability of I2C on mpc52xx.
According to menuconfig's help it isn't still stable as it says:
"The driver may also work on 52xx family processors, though interrupts are =

known not to work"

However there has been a patch from Domen Puncer that apparently fixed the =

driver in 2.6.23.

commit 254db9b5e7b1b0d38a4f177c2c23a5685c78221a
Author: Domen Puncer <domen.puncer@telargo.com>
Date:   Thu Jul 12 14:12:31 2007 +0200

    i2c-mpc: work around missing-9th-clock-pulse bug
=20
    Work around a problem reported on:
    http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019038.html
    Without this patch I2C on mpc5200 becomes unusable after a while.
    Tested on mpc5200 boards by Matthias Fechner and me.
=20
    Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
    Signed-off-by: Jean Delvare <khali@linux-fr.org>


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
--=_alternative 0062F413C12573F4_=
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


<br><font size=3D2 face=3D"sans-serif">Hello all,</font><br><br><font size=
=3D2 face=3D"sans-serif">I have a question regarding the stability of I2C o=
n mpc52xx.</font><br><font size=3D2 face=3D"sans-serif">According to menuco=
nfig's help it isn't still stable as it says:</font><br><font size=3D2 face=
=3D"sans-serif">&quot;The driver may also work on 52xx family processors, t=
hough interrupts are known not to work&quot;</font><br><br><font size=3D2 f=
ace=3D"sans-serif">However there has been a patch from Domen Puncer that ap=
parently fixed the driver in 2.6.23.<br></font><br><font size=3D2><tt>commi=
t 254db9b5e7b1b0d38a4f177c2c23a5685c78221a</tt></font><br><font size=3D2><t=
t>Author: Domen Puncer &lt;domen.puncer@telargo.com&gt;</tt></font><br><fon=
t size=3D2><tt>Date: &nbsp; Thu Jul 12 14:12:31 2007 +0200</tt></font><br><=
br><font size=3D2><tt>&nbsp; &nbsp; i2c-mpc: work around missing-9th-clock-=
pulse bug</tt></font><br><font size=3D2><tt>&nbsp; &nbsp; </tt></font><br><=
font size=3D2><tt>&nbsp; &nbsp; Work around a problem reported on:</tt></fo=
nt><br><font size=3D2><tt>&nbsp; &nbsp; http://ozlabs.org/pipermail/linuxpp=
c-embedded/2005-July/019038.html</tt></font><br><font size=3D2><tt>&nbsp; &=
nbsp; Without this patch I2C on mpc5200 becomes unusable after a while.</tt=
></font><br><font size=3D2><tt>&nbsp; &nbsp; Tested on mpc5200 boards by Ma=
tthias Fechner and me.</tt></font><br><font size=3D2><tt>&nbsp; &nbsp; </tt=
></font><br><font size=3D2><tt>&nbsp; &nbsp; Signed-off-by: Domen Puncer &l=
t;domen.puncer@telargo.com&gt;</tt></font><br><font size=3D2><tt>&nbsp; &nb=
sp; Signed-off-by: Jean Delvare &lt;khali@linux-fr.org&gt;</tt></font><br><=
br><br><font size=3D2 face=3D"sans-serif">If any kind soul could provide a =
status I'd be glad to provide the patch for the help file...</font><br><fon=
t size=3D2 face=3D"sans-serif">Thanks,</font><br><br><font size=3D2 face=3D=
"sans-serif">Eric Dujardin<br></font><BR>
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
--=_alternative 0062F413C12573F4_=--
