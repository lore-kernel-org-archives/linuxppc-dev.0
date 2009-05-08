Return-Path: <jcrigby@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id AE890DDF7A
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 12:41:28 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so933100wfg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 07 May 2009 19:41:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40905061540x96c1524hd88ee78bc366b89b@mail.gmail.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-11-git-send-email-wd@denx.de>
	<20090506210644.GA17311@pengutronix.de>
	<fa686aa40905061540x96c1524hd88ee78bc366b89b@mail.gmail.com>
Date: Thu, 7 May 2009 20:41:26 -0600
Message-ID: <4b73d43f0905071941xaa78e4dj41f7396ff227af31@mail.gmail.com>
Subject: Re: [rtc-linux] Re: [PATCH 10/12] mpc5121: Add MPC5121 Real time
	clock driver.
From: John Rigby <jcrigby@gmail.com>
To: rtc-linux@googlegroups.com
Content-Type: multipart/alternative; boundary=000e0cd32d06ad4f7804695d9004
Cc: linuxppc-dev@ozlabs.org, Piotr Ziecik <kosmo@semihalf.com>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd32d06ad4f7804695d9004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Can we get 5121 support in and add 5200 support later?  They are not
identical.

On Wed, May 6, 2009 at 4:40 PM, Grant Likely <grant.likely@secretlab.ca>wrote:

>
> On Wed, May 6, 2009 at 3:06 PM, Wolfram Sang <w.sang@pengutronix.de>
> wrote:
> > On Wed, May 06, 2009 at 10:15:17PM +0200, Wolfgang Denk wrote:
> >> From: John Rigby <jrigby@freescale.com>
> >>
> >> Based on Domen Puncer's rtc driver for 5200 posted to
> >> the ppclinux mailing list:
> >>       http://patchwork.ozlabs.org/linuxppc-embedded/patch?id=11675
> >> but never commited anywhere.
> >>
> >> Changes to Domen's original:
> >>
> >>     Changed filenames/routine names from mpc5200* to mpc5121*
> >
> > Why not changing it to mpc5xxx? From a glimpse, it should still work on
> > MPC5200, too.
>
> If this is true, the I heartily agree with Wolfram.  :-)
>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>
> --~--~---------~--~----~------------~-------~--~----~
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.
> -~----------~----~----~----~------~----~------~--~---
>
>

--000e0cd32d06ad4f7804695d9004
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Can we get 5121 support in and add 5200 support later?=A0 They are not iden=
tical.<br><br><div class=3D"gmail_quote">On Wed, May 6, 2009 at 4:40 PM, Gr=
ant Likely <span dir=3D"ltr">&lt;<a href=3D"mailto:grant.likely@secretlab.c=
a">grant.likely@secretlab.ca</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
><br>
On Wed, May 6, 2009 at 3:06 PM, Wolfram Sang &lt;<a href=3D"mailto:w.sang@p=
engutronix.de">w.sang@pengutronix.de</a>&gt; wrote:<br>
&gt; On Wed, May 06, 2009 at 10:15:17PM +0200, Wolfgang Denk wrote:<br>
&gt;&gt; From: John Rigby &lt;<a href=3D"mailto:jrigby@freescale.com">jrigb=
y@freescale.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Based on Domen Puncer&#39;s rtc driver for 5200 posted to<br>
&gt;&gt; the ppclinux mailing list:<br>
&gt;&gt; =A0 =A0 =A0 <a href=3D"http://patchwork.ozlabs.org/linuxppc-embedd=
ed/patch?id=3D11675" target=3D"_blank">http://patchwork.ozlabs.org/linuxppc=
-embedded/patch?id=3D11675</a><br>
&gt;&gt; but never commited anywhere.<br>
&gt;&gt;<br>
&gt;&gt; Changes to Domen&#39;s original:<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0 Changed filenames/routine names from mpc5200* to mpc5121*<=
br>
&gt;<br>
&gt; Why not changing it to mpc5xxx? From a glimpse, it should still work o=
n<br>
&gt; MPC5200, too.<br>
<br>
</div>If this is true, the I heartily agree with Wolfram. =A0:-)<br>
<font color=3D"#888888"><br>
g.<br>
</font><div class=3D"im"><br>
--<br>
Grant Likely, B.Sc., P.Eng.<br>
Secret Lab Technologies Ltd.<br>
<br>
</div><div><div></div><div class=3D"h5">--~--~---------~--~----~-----------=
-~-------~--~----~<br>
You received this message because you are subscribed to &quot;rtc-linux&quo=
t;.<br>
Membership options at <a href=3D"http://groups.google.com/group/rtc-linux" =
target=3D"_blank">http://groups.google.com/group/rtc-linux</a> .<br>
Please read <a href=3D"http://groups.google.com/group/rtc-linux/web/checkli=
st" target=3D"_blank">http://groups.google.com/group/rtc-linux/web/checklis=
t</a><br>
before submitting a driver.<br>
-~----------~----~----~----~------~----~------~--~---<br>
<br>
</div></div></blockquote></div><br>

--000e0cd32d06ad4f7804695d9004--
