Return-Path: <justinmattock@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C21CC1007D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2011 06:26:44 +1100 (EST)
Received: by eaad12 with SMTP id d12so2342088eaa.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 11:26:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1112151845550.23478@pobox.suse.cz>
References: <1321893808-3721-1-git-send-email-justinmattock@gmail.com>
 <4EEA2A5A.2050008@gmail.com>
 <alpine.LNX.2.00.1112151845550.23478@pobox.suse.cz>
Date: Thu, 15 Dec 2011 11:26:39 -0800
Message-ID: <CAKFRV=PeN3feta_VM4ERvyuf=fDXMxO85RZxT6y8PM-1X89dxA@mail.gmail.com>
Subject: Re: [PATCH 1/3]arch:powerpc:sysdev:mpic.c Remove extra semicolon.
From: Justin Mattock <justinmattock@gmail.com>
To: Jiri Kosina <jkosina@suse.cz>
Content-Type: multipart/alternative; boundary=0015175cd2a8ab963604b42676c8
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0015175cd2a8ab963604b42676c8
Content-Type: text/plain; charset=ISO-8859-1

Ill check through the commits.. Thank you for applying..

On Dec 15, 2011 9:46 AM, "Jiri Kosina" <jkosina@suse.cz> wrote:

> On Thu, 15 Dec 2011, Justin P. Mattock wrote:
>
> > what would be the status of these? should I resend/rebase to the current
> > etc?..
>
> Check linux-next, it's already there.
>
> >
> > On 11/21/2011 08:43 AM, Justin P. Mattock wrote:
> > > From: "Justin P. Mattock"<justinmattock@gmail.com>
> > >
> > > The patch below removes an extra semicolon.
> > >
> > > Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
> > > CC: linuxppc-dev@lists.ozlabs.org
> > > CC: Paul Mackerras<paulus@samba.org>
> > > ---
> > >   arch/powerpc/sysdev/mpic.c |    2 +-
> > >   1 files changed, 1 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> > > index 8c7e852..b3fa3d7 100644
> > > --- a/arch/powerpc/sysdev/mpic.c
> > > +++ b/arch/powerpc/sysdev/mpic.c
> > > @@ -901,7 +901,7 @@ int mpic_set_irq_type(struct irq_data *d, unsigned
> int
> > > flow_type)
> > >     if (vold != vnew)
> > >             mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI), vnew);
> > >
> > > -   return IRQ_SET_MASK_OK_NOCOPY;;
> > > +   return IRQ_SET_MASK_OK_NOCOPY;
> > >   }
> > >
> > >   void mpic_set_vector(unsigned int virq, unsigned int vector)
> >
>
> --
> Jiri Kosina
> SUSE Labs
>

--0015175cd2a8ab963604b42676c8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Ill check through the commits.. Thank you for applying..</p>
<p>On Dec 15, 2011 9:46 AM, &quot;Jiri Kosina&quot; &lt;<a href=3D"mailto:j=
kosina@suse.cz">jkosina@suse.cz</a>&gt; wrote:<br type=3D"attribution"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
On Thu, 15 Dec 2011, Justin P. Mattock wrote:<br>
<br>
&gt; what would be the status of these? should I resend/rebase to the curre=
nt<br>
&gt; etc?..<br>
<br>
Check linux-next, it&#39;s already there.<br>
<br>
&gt;<br>
&gt; On 11/21/2011 08:43 AM, Justin P. Mattock wrote:<br>
&gt; &gt; From: &quot;Justin P. Mattock&quot;&lt;<a href=3D"mailto:justinma=
ttock@gmail.com">justinmattock@gmail.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; The patch below removes an extra semicolon.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Justin P. Mattock&lt;<a href=3D"mailto:justinmatto=
ck@gmail.com">justinmattock@gmail.com</a>&gt;<br>
&gt; &gt; CC: <a href=3D"mailto:linuxppc-dev@lists.ozlabs.org">linuxppc-dev=
@lists.ozlabs.org</a><br>
&gt; &gt; CC: Paul Mackerras&lt;<a href=3D"mailto:paulus@samba.org">paulus@=
samba.org</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; =A0 arch/powerpc/sysdev/mpic.c | =A0 =A02 +-<br>
&gt; &gt; =A0 1 files changed, 1 insertions(+), 1 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpi=
c.c<br>
&gt; &gt; index 8c7e852..b3fa3d7 100644<br>
&gt; &gt; --- a/arch/powerpc/sysdev/mpic.c<br>
&gt; &gt; +++ b/arch/powerpc/sysdev/mpic.c<br>
&gt; &gt; @@ -901,7 +901,7 @@ int mpic_set_irq_type(struct irq_data *d, uns=
igned int<br>
&gt; &gt; flow_type)<br>
&gt; &gt; =A0 =A0 if (vold !=3D vnew)<br>
&gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_=
PRI), vnew);<br>
&gt; &gt;<br>
&gt; &gt; - =A0 return IRQ_SET_MASK_OK_NOCOPY;;<br>
&gt; &gt; + =A0 return IRQ_SET_MASK_OK_NOCOPY;<br>
&gt; &gt; =A0 }<br>
&gt; &gt;<br>
&gt; &gt; =A0 void mpic_set_vector(unsigned int virq, unsigned int vector)<=
br>
&gt;<br>
<br>
--<br>
Jiri Kosina<br>
SUSE Labs<br>
</blockquote></p>

--0015175cd2a8ab963604b42676c8--
