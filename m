Return-Path: <glikely@secretlab.ca>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
 [209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 37B701007D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2012 17:50:40 +1100 (EST)
Received: by obcwn6 with SMTP id wn6so2164160obc.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2012 22:50:38 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1326853009.26116.30.camel@pasglop>
References: <1326313337-24603-1-git-send-email-grant.likely@secretlab.ca>
 <1326313337-24603-14-git-send-email-grant.likely@secretlab.ca>
 <4F0DFC0F.2090005@gmail.com>
 <CACxGe6vVSO0cTgPurr6jFoo9QF_W02UaABOFYadCTQGU9dcwmg@mail.gmail.com>
 <4F0F7B60.5040701@gmail.com> <4F14E05C.30207@codeaurora.org>
 <1326771731.26116.29.camel@pasglop>
 <CACxGe6ufk+BUoXZBKm5Q-O1Aj1j=18fJ5KjOC-fKQMbpw4z=mw@mail.gmail.com>
 <1326853009.26116.30.camel@pasglop>
Date: Tue, 17 Jan 2012 23:50:37 -0700
Message-ID: <CACxGe6u5MEYYLyEij=TEDmrWb3A5yapm3SPiBXGzWTVZ1yUkig@mail.gmail.com>
Subject: Re: [RFC 13/14] irq_domain: Remove 'new' irq_domain in favour of the
 ppc one
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=f46d0447887783d36404b6c7dd7b
Cc: sfr@canb.auug.org.au, Russell King <linux@arm.linux.org.uk>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robherring2@gmail.com>, Michael Bohan <mbohan@codeaurora.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f46d0447887783d36404b6c7dd7b
Content-Type: text/plain; charset=ISO-8859-1

On Jan 17, 2012 7:17 PM, "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
wrote:
>
> On Tue, 2012-01-17 at 17:28 -0700, Grant Likely wrote:
> > BTW: Ben, if you can carve out some time, I'd appreciate a look over
> > my series and make sure you're okay with it.  Once it's had some
> > testing by arm and ppc folks, I want to get it into linux-next.
>
> I intend to do so but not while I'm at LCA :-)

Pish... slacker.

:-p

No problem, enjoy LCA. One of these years I need to make it over there.

g.

--f46d0447887783d36404b6c7dd7b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p><br>
On Jan 17, 2012 7:17 PM, &quot;Benjamin Herrenschmidt&quot; &lt;<a href=3D"=
mailto:benh@kernel.crashing.org">benh@kernel.crashing.org</a>&gt; wrote:<br=
>
&gt;<br>
&gt; On Tue, 2012-01-17 at 17:28 -0700, Grant Likely wrote:<br>
&gt; &gt; BTW: Ben, if you can carve out some time, I&#39;d appreciate a lo=
ok over<br>
&gt; &gt; my series and make sure you&#39;re okay with it. =A0Once it&#39;s=
 had some<br>
&gt; &gt; testing by arm and ppc folks, I want to get it into linux-next.<b=
r>
&gt;<br>
&gt; I intend to do so but not while I&#39;m at LCA :-)</p>
<p>Pish... slacker.</p>
<p> :-p<br></p>
<p>No problem, enjoy LCA. One of these years I need to make it over there.<=
/p>
<p>g.<br>
</p>

--f46d0447887783d36404b6c7dd7b--
