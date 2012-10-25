Return-Path: <jeremy@jeremyelgin.me>
Received: from mail-pool.jeremyelgin.net (liberator.jeremyelgin.net
 [202.50.176.80])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B78C32C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2012 14:21:02 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail-pool.jeremyelgin.net (Postfix) with ESMTP id DF11234B6F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2012 16:14:03 +1300 (NZDT)
Received: from mail-pool.jeremyelgin.net ([127.0.0.1])
 by localhost (mail-filter.jeremyelgin.net [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id SF7JHiuHI+qv for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 25 Oct 2012 16:13:59 +1300 (NZDT)
Received: from [192.168.250.1] (222-154-130-160.jetstream.xtra.co.nz
 [222.154.130.160])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: jeremy@jeremyelgin.me)
 by mail-pool.jeremyelgin.net (Postfix) with ESMTPSA id E8BBD34B6F1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2012 16:13:58 +1300 (NZDT)
From: Jeremy Elgin <jeremy@jeremyelgin.me>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_053A1B86-15E4-420A-AA55-3389525AE925"
Subject: iMac (PM61) quieter fan?
Message-Id: <26F74A8F-8BCD-4E97-99F4-8DF14C2568D6@jeremyelgin.me>
Date: Thu, 25 Oct 2012 16:13:59 +1300
To: linuxppc-dev@lists.ozlabs.org
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_053A1B86-15E4-420A-AA55-3389525AE925
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

I'm running Ubuntu 12.04 on my iMac G4 1GHz (PowerMac6,1) and I've been =
looking for any installable option to quiet the fan, nothing I've found =
mentions PowerMac6,1 and the modules installed don't even mention =
different PM models, just therm_windtunnel.ko & windfarm_core.ko - this =
first module won't load (No such device) and the second isn't used by =
anything (yet), do I need to install a .deb package that'll talk to this =
module?

I know this is not really about development but it's specific to PPC, =
ok? :-)

Oh, I also have a Dual 2.0 GHz G5 (PowerMac7,3) that I'm keen to get =
Ubuntu running on as a headless server and it'll need fan controls too. =
What I mean to say is, I'm keen to help out with these two pieces of =
hardware should you need testers for them specifically.


--Apple-Mail=_053A1B86-15E4-420A-AA55-3389525AE925
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"><meta http-equiv=3D"Content-Type" content=3D"text/html=
 charset=3Dus-ascii"><meta http-equiv=3D"Content-Type" =
content=3D"text/html charset=3Dus-ascii"><meta http-equiv=3D"Content-Type"=
 content=3D"text/html charset=3Dus-ascii"></head><body style=3D"word-wrap:=
 break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space; ">I'm running Ubuntu 12.04 on my iMac G4 1GHz =
(PowerMac6,1) and I've been looking for any installable option to quiet =
the fan, nothing I've found mentions PowerMac6,1 and the modules =
installed don't even mention different PM models, just =
therm_windtunnel.ko &amp; windfarm_core.ko - this first module won't =
load (No such device) and the second isn't used by anything (yet), do I =
need to install a .deb package that'll talk to this module?<br><br>I =
know this is not really about development but it's specific to PPC, ok? =
:-)<br><br><div>Oh, I also have a Dual 2.0 GHz G5 (PowerMac7,3) that I'm =
keen to get Ubuntu running on as a headless server and it'll need fan =
controls too. <b>What I mean to say is, I'm keen to help out with these =
two pieces of hardware should you need testers for them =
specifically.</b><br><br></div></body></html>=

--Apple-Mail=_053A1B86-15E4-420A-AA55-3389525AE925--
