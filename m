Return-Path: <michael.neuling@gmail.com>
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com
 [IPv6:2607:f8b0:400c:c08::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wv25L1hkMzDqjM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 12:12:06 +1000 (AEST)
Received: by mail-ua0-x244.google.com with SMTP id g40so4023712uaa.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 19:12:05 -0700 (PDT)
MIME-Version: 1.0
Sender: michael.neuling@gmail.com
In-Reply-To: <87lgojy1bk.fsf@linux.vnet.ibm.com>
References: <20170622172616.7598-1-mikey@neuling.org>
 <87lgojy1bk.fsf@linux.vnet.ibm.com>
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 23 Jun 2017 12:12:00 +1000
Message-ID: <CAEjGV6y6v1Z=dHbJKK=4Atky0zBhxGsPTc9iPiDTNxFP_y13dg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Invalidate ERAT on powersave wakeup for POWER9
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Content-Type: multipart/alternative; boundary="94eb2c03cd5e711b3205529720b7"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c03cd5e711b3205529720b7
Content-Type: text/plain; charset="UTF-8"

Yes please... Would be helpful


On 22 Jun. 2017 7:50 pm, "Stewart Smith" <stewart@linux.vnet.ibm.com> wrote:

> Michael Neuling <mikey@neuling.org> writes:
> > On POWER9 the ERAT may be incorrect on wakeup from some stop states
> > that lose state. This causes random segvs and illegal instructions
> > when these stop states are enabled.
> >
> > This patch invalidates the ERAT on wakeup on POWER9 to prevent this
> > from causing a problem.
> >
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
>
> CC: stable?
>
> --
> Stewart Smith
> OPAL Architect, IBM.
>
>

--94eb2c03cd5e711b3205529720b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yes please... Would be helpful<div dir=3D"auto"><br></div=
></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 22 Jun.=
 2017 7:50 pm, &quot;Stewart Smith&quot; &lt;<a href=3D"mailto:stewart@linu=
x.vnet.ibm.com">stewart@linux.vnet.ibm.com</a>&gt; wrote:<br type=3D"attrib=
ution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">Michael Neuling &lt;<a href=3D"mailto=
:mikey@neuling.org">mikey@neuling.org</a>&gt; writes:<br>
&gt; On POWER9 the ERAT may be incorrect on wakeup from some stop states<br=
>
&gt; that lose state. This causes random segvs and illegal instructions<br>
&gt; when these stop states are enabled.<br>
&gt;<br>
&gt; This patch invalidates the ERAT on wakeup on POWER9 to prevent this<br=
>
&gt; from causing a problem.<br>
&gt;<br>
&gt; Signed-off-by: Michael Neuling &lt;<a href=3D"mailto:mikey@neuling.org=
">mikey@neuling.org</a>&gt;<br>
<br>
CC: stable?<br>
<br>
--<br>
Stewart Smith<br>
OPAL Architect, IBM.<br>
<br>
</blockquote></div></div>

--94eb2c03cd5e711b3205529720b7--
