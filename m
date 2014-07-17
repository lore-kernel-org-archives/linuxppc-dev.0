Return-Path: <michael.neuling@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F24081A01DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 21:14:55 +1000 (EST)
Received: from mail-la0-x236.google.com (mail-la0-x236.google.com
 [IPv6:2a00:1450:4010:c03::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 29E3F14008B
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2014 21:14:54 +1000 (EST)
Received: by mail-la0-f54.google.com with SMTP id el20so1623499lab.27
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2014 04:14:51 -0700 (PDT)
MIME-Version: 1.0
Sender: michael.neuling@gmail.com
In-Reply-To: <1405595380.25310.21.camel@pasglop>
References: <1400858138-3939-1-git-send-email-khandual@linux.vnet.ibm.com>
 <53996E41.4070309@linux.vnet.ibm.com>
 <53C7A4FA.4030600@linux.vnet.ibm.com>
 <1405595380.25310.21.camel@pasglop>
Date: Thu, 17 Jul 2014 21:14:51 +1000
Message-ID: <CAEjGV6yK_9DS1cLQ2BH=HFi029N8rz-4Wyvwzdb_gy6PnJgbwg@mail.gmail.com>
Subject: Re: [PATCH V3 0/3] Add new PowerPC specific ELF core notes
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=001a11c370dce713fa04fe61bfd3
Cc: james.hogan@imgtec.com, avagin@openvz.org, Paul.Clothier@imgtec.com,
 Peter Zijlstra <peterz@infradead.org>, Pedro Alves <palves@redhat.com>,
 oleg@redhat.com, akpm@linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, davej@redhat.com, tglx@linutronix.de,
 "David S. Miller" <davem@davemloft.net>, sam.bobroff@au1.ibm.com,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11c370dce713fa04fe61bfd3
Content-Type: text/plain; charset=UTF-8

On Jul 17, 2014 9:11 PM, "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
wrote:
>
> > >
> > >> Outstanding Issues
> > >> ==================
> > >> (1) Running DSCR register value inside a transaction does not seem
to be saved
> > >>     at thread.dscr when the process stops for ptrace examination.
> > >
> > > Hey Ben,
> > >
> > > Any updates on this patch series ?
> >
> > Ben,
> >
> > Any updates on this patch series ?
>
> I haven't had a chance to review yet, I was hoping somebody else would..
>
> Have you made any progress vs. the DSCR outstanding issue mentioned
> above ?

The DSCR issue should be resolved with Sam Bobroff's recent  DSCR fixes.
I've not tested them though.

Actually... Sam did you review this series?

Mikey

--001a11c370dce713fa04fe61bfd3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Jul 17, 2014 9:11 PM, &quot;Benjamin Herrenschmidt&quot; &lt;<a href=3D"=
mailto:benh@kernel.crashing.org">benh@kernel.crashing.org</a>&gt; wrote:<br=
>
&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&gt; Outstanding Issues<br>
&gt; &gt; &gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<b=
r>
&gt; &gt; &gt;&gt; (1) Running DSCR register value inside a transaction doe=
s not seem to be saved<br>
&gt; &gt; &gt;&gt; =C2=A0 =C2=A0 at thread.dscr when the process stops for =
ptrace examination.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Hey Ben,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Any updates on this patch series ?<br>
&gt; &gt;<br>
&gt; &gt; Ben,<br>
&gt; &gt;<br>
&gt; &gt; Any updates on this patch series ?<br>
&gt;<br>
&gt; I haven&#39;t had a chance to review yet, I was hoping somebody else w=
ould..<br>
&gt;<br>
&gt; Have you made any progress vs. the DSCR outstanding issue mentioned<br=
>
&gt; above ?</p>
<p dir=3D"ltr">The DSCR issue should be resolved with Sam Bobroff&#39;s rec=
ent=C2=A0 DSCR fixes.=C2=A0 I&#39;ve not tested them though.</p>
<p dir=3D"ltr">Actually... Sam did you review this series? </p>
<p dir=3D"ltr">Mikey<br>
</p>

--001a11c370dce713fa04fe61bfd3--
