Return-Path: <oohall@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2n1s4lBGzDqFb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 21:50:25 +1100 (AEDT)
Received: by mail-qt0-x241.google.com with SMTP id l7so20581238qtd.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 02:50:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87a8aqau99.fsf@concordia.ellerman.id.au>
References: <20170112035413.26544-1-ruscur@russell.cc>
 <1484293883.2406.1.camel@gmail.com>
 <87a8aqau99.fsf@concordia.ellerman.id.au>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Tue, 17 Jan 2017 21:50:20 +1100
Message-ID: <CAOSf1CGDkoTjZS6NxV42GfP=oGCvF4cdC4Dsv79WkZAXVZV3NA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Use octal numbers for file permissions
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org,
 Cyril Bur <cyrilbur@gmail.com>
Content-Type: multipart/alternative; boundary=001a11c01cd413cae4054648118d
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a11c01cd413cae4054648118d
Content-Type: text/plain; charset=UTF-8

"It's possible I missed one, but I did genuinely review all of it"

Cyril Bur, 2016
In a hobart pub, specifically The Winston

On 17/01/2017 8:53 PM, "Michael Ellerman" <mpe@ellerman.id.au> wrote:

> Cyril Bur <cyrilbur@gmail.com> writes:
>
> > On Thu, 2017-01-12 at 14:54 +1100, Russell Currey wrote:
> >> Symbolic macros are unintuitive and hard to read, whereas octal
> constants
> >> are much easier to interpret.  Replace macros for the basic permission
> >> flags (user/group/other read/write/execute) with numeric constants
> >> instead, across the whole powerpc tree.
> >>
> >> Introducing a significant number of changes across the tree for no
> runtime
> >> benefit isn't exactly desirable, but so long as these macros are still
> >> used in the tree people will keep sending patches that add them.  Not
> only
> >> are they hard to parse at a glance, there are multiple ways of coming to
> >> the same value (as you can see with 0444 and 0644 in this patch) which
> >> hurts readability.
> >>
> >> Signed-off-by: Russell Currey <ruscur@russell.cc>
> >
> > Reviewed-by: Cyril Bur <cyrilbur@gmail.com>
>
> Did you really really review every single change?
>
> Because if you did then I don't have to, and that would be *great* :)
>
> cheers
>

--001a11c01cd413cae4054648118d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">&quot;It&#39;s possible I missed one, but I did genuinely re=
view all of it&quot;</p>
<p dir=3D"ltr">Cyril Bur, 2016<br>
In a hobart pub, specifically The Winston</p>
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 17/01/2017 8:5=
3 PM, &quot;Michael Ellerman&quot; &lt;<a href=3D"mailto:mpe@ellerman.id.au=
">mpe@ellerman.id.au</a>&gt; wrote:<br type=3D"attribution"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">Cyril Bur &lt;<a href=3D"mailto:cyrilbur@gmail.com">cyrilbu=
r@gmail.com</a>&gt; writes:<br>
<br>
&gt; On Thu, 2017-01-12 at 14:54 +1100, Russell Currey wrote:<br>
&gt;&gt; Symbolic macros are unintuitive and hard to read, whereas octal co=
nstants<br>
&gt;&gt; are much easier to interpret.=C2=A0 Replace macros for the basic p=
ermission<br>
&gt;&gt; flags (user/group/other read/write/execute) with numeric constants=
<br>
&gt;&gt; instead, across the whole powerpc tree.<br>
&gt;&gt;<br>
&gt;&gt; Introducing a significant number of changes across the tree for no=
 runtime<br>
&gt;&gt; benefit isn&#39;t exactly desirable, but so long as these macros a=
re still<br>
&gt;&gt; used in the tree people will keep sending patches that add them.=
=C2=A0 Not only<br>
&gt;&gt; are they hard to parse at a glance, there are multiple ways of com=
ing to<br>
&gt;&gt; the same value (as you can see with 0444 and 0644 in this patch) w=
hich<br>
&gt;&gt; hurts readability.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Russell Currey &lt;ruscur@russell.cc&gt;<br>
&gt;<br>
&gt; Reviewed-by: Cyril Bur &lt;<a href=3D"mailto:cyrilbur@gmail.com">cyril=
bur@gmail.com</a>&gt;<br>
<br>
Did you really really review every single change?<br>
<br>
Because if you did then I don&#39;t have to, and that would be *great* :)<b=
r>
<br>
cheers<br>
</blockquote></div></div>

--001a11c01cd413cae4054648118d--
