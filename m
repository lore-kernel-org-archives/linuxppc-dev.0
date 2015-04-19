Return-Path: <ajitsp2001@gmail.com>
Received: from mail-ob0-x22c.google.com (mail-ob0-x22c.google.com
 [IPv6:2607:f8b0:4003:c01::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA00A1A0BC5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2015 17:49:29 +1000 (AEST)
Received: by oblw8 with SMTP id w8so99017071obl.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Apr 2015 00:49:27 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 19 Apr 2015 13:19:27 +0530
Message-ID: <CAKNr0CiLK3bfGWzuwEs1KHqeCan6q5bPJ2psn6gNmBTobCS3Ug@mail.gmail.com>
Subject: uboot parsing
From: Ajit Phadnis <ajitsp2001@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001a11c2b79a8750de05140f0def
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11c2b79a8750de05140f0def
Content-Type: text/plain; charset=UTF-8

Hi Folks,

Would like to how to store the response command of a run command


=>setenv addr  'ping 192.172.24.24'

=>setenv ping_resp 'run  addr'

Would to store the outcome of  "run addr" in into a variable and grep for
the characters or string in Uboot.

// Expecting the output as ping response string and parse the outcome with
grep !!
=> echo $ping_respone


-- 
Thanks,
Ajit

--001a11c2b79a8750de05140f0def
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Folks,<div><br></div><div>Would like to how to store th=
e response command of a run command</div><div><br></div><div><br></div><div=
>=3D&gt;setenv addr =C2=A0&#39;ping 192.172.24.24&#39;</div><div><br></div>=
<div>=3D&gt;setenv ping_resp &#39;run =C2=A0addr&#39;<br></div><div><div><b=
r></div><div>Would to store the outcome of =C2=A0&quot;run addr&quot; in in=
to a variable and grep for the characters or string in Uboot.</div><div><br=
></div><div>// Expecting the output as ping response string and parse the o=
utcome with grep !!</div><div>=3D&gt; echo $ping_respone=C2=A0</div><div><b=
r></div><div><br></div>-- <br><div class=3D"gmail_signature"><font color=3D=
"#ff6600">Thanks,</font><div><font color=3D"#ff6600">Ajit</font></div></div=
>
</div></div>

--001a11c2b79a8750de05140f0def--
