Date: Tue, 9 Mar 2004 10:20:50 +0100
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Message-ID: <Pine.LNX.4.44.0403091013500.16007@linpc003.aimsys.nl>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: searchplugin (off topic)
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yxYTAz6wCd0OS+U"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary-00=_yxYTAz6wCd0OS+U
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

For anybody interested, I've attached a
mozilla/firefox/etc. searchplugin for
this mailing list. Just put in your
<browser install>/searchplugins directory
and restart.

Jaap-Jan


--
J.G.J. Boor			  Anton Philipsweg 1
Software Engineer		  1223 KZ Hilversum
AimSys bv              		  tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl


--Boundary-00=_yxYTAz6wCd0OS+U
Content-Type: text/plain;
  charset="us-ascii";
  name="linuxppc.src"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linuxppc.src"

# linuxppc-embedded Sherlock for Mozilla
#
# jjboor at aimsys dot nl March 2004
#

<search
   name="linuxppc-embedded"
   description="LinuxPPC - Mail List Archives"
   action="http://lists.linuxppc.org/results.html"
   searchForm="http://lists.linuxppc.org/results.html"
   method="GET" >

<input name="restrict" value="linuxppc-embedded">
<input name="words" user >

<interpret

    resultListStart="<!-- RESULT LIST START -->"
    resultListEnd="<!-- RESULT LIST END -->"

    resultItemStart="<!-- RESULT ITEM START -->"
    resultItemEnd="<!-- RESULT ITEM END -->"
>
</search>

--Boundary-00=_yxYTAz6wCd0OS+U--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
