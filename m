Return-Path: <jcrigby@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DFA9BB70B7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 10:08:25 +1000 (EST)
Received: from mail-px0-f176.google.com (mail-px0-f176.google.com
	[209.85.216.176]) by ozlabs.org (Postfix) with ESMTP id 2867CDDD0B
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 10:08:24 +1000 (EST)
Received: by pxi6 with SMTP id 6so3069452pxi.17
	for <linuxppc-dev@ozlabs.org>; Sat, 06 Jun 2009 17:08:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090606232148.4E0BD832E416@gemini.denx.de>
References: <1241641262-5202-1-git-send-email-wd@denx.de>
	<1241641262-5202-6-git-send-email-wd@denx.de>
	<4b73d43f0905071909v6e6e8b2el9eb6d4a1b9038f45@mail.gmail.com>
	<20090606221618.701E0832E416@gemini.denx.de>
	<4b73d43f0906061527p7ca1b301ybcfc576870a168d5@mail.gmail.com>
	<20090606232148.4E0BD832E416@gemini.denx.de>
Date: Sat, 6 Jun 2009 18:08:23 -0600
Message-ID: <4b73d43f0906061708o763409d0u10a344dfc30e32c1@mail.gmail.com>
Subject: Re: [PATCH 05/04] *** NOT FOR RELEASE *** HACK *** Work around MII
	clock issue ***
From: John Rigby <jcrigby@gmail.com>
To: Wolfgang Denk <wd@denx.de>
Content-Type: multipart/alternative; boundary=00504502c3d2866c2c046bb6ece1
Cc: linuxppc-dev@ozlabs.org, Chen Hongjun <Hong-jun.chen@freecale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00504502c3d2866c2c046bb6ece1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

>
>
>
> The big question seems to be what the RefMan means when talking about
> the "system clock frequency". Obiously it is NOT  the  CPU  clock  as
> code variants above assume. The examples in "Table 17-24. Programming
> Examples  for  MII_SPEED Register" list "system clock frequencies" of
> 25, 33, 40 and 50  MHz  -  which  also  indiocates  that  some  other
> frequency might be referenced here.
>
> But which one is it?


My best guess is still that it is ips clock.  I think I stated in a previous
email ipb, but I meant ips.  5200 has ibp and 5121 has ips.  Have you looked
at he MII clock on a scope to see how the calculated values compare to
actual?

>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> "Today's robots are very primitive, capable of understanding  only  a
> few  simple  instructions  such  as 'go left', 'go right', and 'build
> car'."                                                  - John Sladek
>

--00504502c3d2866c2c046bb6ece1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"borde=
r-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-le=
ft: 1ex;"><br>
<br>
The big question seems to be what the RefMan means when talking about<br>
the &quot;system clock frequency&quot;. Obiously it is NOT =A0the =A0CPU =
=A0clock =A0as<br>
code variants above assume. The examples in &quot;Table 17-24. Programming<=
br>
Examples =A0for =A0MII_SPEED Register&quot; list &quot;system clock frequen=
cies&quot; of<br>
25, 33, 40 and 50 =A0MHz =A0- =A0which =A0also =A0indiocates =A0that =A0som=
e =A0other<br>
frequency might be referenced here.<br>
<br>
But which one is it?</blockquote><div><br>My best guess is still that it is=
 ips clock.=A0 I think I stated in a previous email ipb, but I meant ips.=
=A0 5200 has ibp and 5121 has ips.=A0 Have you looked at he MII clock on a =
scope to see how the calculated values compare to actual? <br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<div class=3D"im"><br>
Best regards,<br>
<br>
Wolfgang Denk<br>
<br>
--<br>
DENX Software Engineering GmbH, =A0 =A0 MD: Wolfgang Denk &amp; Detlev Zund=
el<br>
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany<br>
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: <a href=3D"mailt=
o:wd@denx.de">wd@denx.de</a><br>
</div>&quot;Today&#39;s robots are very primitive, capable of understanding=
 =A0only =A0a<br>
few =A0simple =A0instructions =A0such =A0as &#39;go left&#39;, &#39;go righ=
t&#39;, and &#39;build<br>
car&#39;.&quot; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- John Sladek<br>
</blockquote></div><br>

--00504502c3d2866c2c046bb6ece1--
