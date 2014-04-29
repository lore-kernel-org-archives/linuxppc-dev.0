Return-Path: <michael.neuling@gmail.com>
Received: from mail-pb0-f41.google.com (mail-pb0-f41.google.com
 [209.85.160.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 33FEA1400BE
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2014 18:22:34 +1000 (EST)
Received: by mail-pb0-f41.google.com with SMTP id rr13so6878504pbb.0
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2014 01:22:32 -0700 (PDT)
MIME-Version: 1.0
Sender: michael.neuling@gmail.com
In-Reply-To: <535F5BDE.2030309@linux.vnet.ibm.com>
References: <1396422144-11032-1-git-send-email-khandual@linux.vnet.ibm.com>
 <533BD922.4070009@linux.vnet.ibm.com>
 <535F4E10.2020300@linux.vnet.ibm.com>
 <CAEjGV6yi5YY95tM-HY4akN4BGXGn4chA8_sCaqvWx3HPSu2V3w@mail.gmail.com>
 <535F5BDE.2030309@linux.vnet.ibm.com>
Date: Tue, 29 Apr 2014 18:22:31 +1000
Message-ID: <CAEjGV6y8MRiCfRBtWjNfrwKMccROEAJw2rPVc_u+r=tAo2EcHQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add new ptrace request macros on PowerPC
From: Michael Neuling <mikey@neuling.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary=047d7b15a21d21b33c04f82a2261
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
 avagin@openvz.org, roland@redhat.com, oleg@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b15a21d21b33c04f82a2261
Content-Type: text/plain; charset=UTF-8

That's not what that patch does. It shouldn't make any user visible changes
to DSCR or PPR.

Over syscall PPR and DSCR may change. Depending on your test case, that may
be your problem.

Mikey
On 29 Apr 2014 18:02, "Anshuman Khandual" <khandual@linux.vnet.ibm.com>
wrote:

> On 04/29/2014 12:36 PM, Michael Neuling wrote:
> > How is it causing the problem?
>
> As mentioned before, what I thought to be a problem is
> something expected behaviour. So it's not a problem any
> more. DSCR value inside the transaction will fall back
> to default as kernel wont let user specified value to
> remain applied for a long time.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

--047d7b15a21d21b33c04f82a2261
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">That&#39;s not what that patch does. It shouldn&#39;t make a=
ny user visible changes to DSCR or PPR.</p>
<p dir=3D"ltr">Over syscall PPR and DSCR may change. Depending on your test=
 case, that may be your problem.</p>
<p dir=3D"ltr">Mikey</p>
<div class=3D"gmail_quote">On 29 Apr 2014 18:02, &quot;Anshuman Khandual&qu=
ot; &lt;<a href=3D"mailto:khandual@linux.vnet.ibm.com">khandual@linux.vnet.=
ibm.com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
On 04/29/2014 12:36 PM, Michael Neuling wrote:<br>
&gt; How is it causing the problem?<br>
<br>
As mentioned before, what I thought to be a problem is<br>
something expected behaviour. So it&#39;s not a problem any<br>
more. DSCR value inside the transaction will fall back<br>
to default as kernel wont let user specified value to<br>
remain applied for a long time.<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =C2=A0<a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
Please read the FAQ at =C2=A0<a href=3D"http://www.tux.org/lkml/" target=3D=
"_blank">http://www.tux.org/lkml/</a><br>
<br>
</blockquote></div>

--047d7b15a21d21b33c04f82a2261--
