Return-Path: <fkan@apm.com>
Received: from exprod5og103.obsmtp.com (exprod5og103.obsmtp.com [64.18.0.145])
	by ozlabs.org (Postfix) with SMTP id 1E61DB6F18
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jul 2010 09:07:49 +1000 (EST)
Received: by qwf6 with SMTP id 6so968181qwf.18
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 16:07:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C3CE5BA.5060302@ThePTRGroup.com>
References: <12789766042434-git-send-email-fchen@apm.com>
	<4C3CE5BA.5060302@ThePTRGroup.com>
Date: Tue, 13 Jul 2010 16:02:28 -0700
Message-ID: <AANLkTinivQKLbA3TBHTJbPjT-SUX2ynqBzwJzaSRZ2ve@mail.gmail.com>
Subject: Re: [PATCH 1/9 v1.01] Add Synopsys DesignWare HS USB OTG Controller
	driver.
From: Feng Kan <fkan@apm.com>
To: Chuck Meade <chuck@theptrgroup.com>
Content-Type: multipart/alternative; boundary=00c09f83a2c605263c048b4cdd69
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, gregkh@suse.de,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00c09f83a2c605263c048b4cdd69
Content-Type: text/plain; charset=ISO-8859-1

Chuck:

Thanks for the information. Sorry that we missed the patch. It was not done
out of specific reason.
As you have commented, it is a very large patch with alot of changes. We
wanted to submit
the patch to make sure the fundamental structure of the driver align with
the kernel. Once that
is in place, additional patch will be easier. Fushen will make sure this
change is in place on
the next submission.

Thanks
Feng Kan


On Tue, Jul 13, 2010 at 3:16 PM, Chuck Meade <chuck@theptrgroup.com> wrote:

> On 07/12/2010 07:16 PM, Fushen Chen wrote:
> > The DWC OTG driver module provides the initialization and cleanup
> > entry points for the DWC OTG USB driver.
> >
> > Signed-off-by: Fushen Chen <fchen@apm.com>
> > Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
> > ---
>
> This reply is to the patch series, not just this 1/9 patch section.
>
> Fushen, why did you pick and choose which fixes to incorporate from the
> Denx
> tree's version of the dwc_otg driver?
>
> I'm not taking the time here to go through this multipart patch and check
> that
> you incorporated every fix, but I *did* randomly pick one fix that I made
> to that
> driver, to see if you incorporated it, and it appears you did not.
> I would have expected that you would have incorporated the fixes that were
> made
> to this driver in the Denx tree.
>
> The one that I checked is in the data toggle error interrupt handling, in
> handle_hc_chhltd_intr_dma() (see your 5/9 email in this patch series).  It
> looks
> like you left out the fix I made to this logic that averts an interrupt
> storm.
>
> I assume that since I checked one particular fix, and it was missing from
> your
> patch series, that there are likely more fixes you omitted.  Can you
> explain why
> you would leave this out, after Stefan asked you to incorporate the code
> changes
> made in the Denx tree's version of the driver?
>
> Chuck
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



-- 
Feng Kan

--00c09f83a2c605263c048b4cdd69
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Chuck:<div><br></div><div>Thanks for the information. Sorry that we missed =
the patch. It was not done out of specific reason.</div><div>As you have co=
mmented, it is a very large patch with alot of changes. We wanted to submit=
</div>
<div>the patch to make sure the=A0fundamental=A0structure of the driver ali=
gn with the kernel. Once that</div><div>is in place, additional patch will =
be easier. Fushen will make sure this change is in place on</div><div>the n=
ext submission.</div>
<div><br></div><div>Thanks</div><div>Feng Kan</div><div><br><br><div class=
=3D"gmail_quote">On Tue, Jul 13, 2010 at 3:16 PM, Chuck Meade <span dir=3D"=
ltr">&lt;<a href=3D"mailto:chuck@theptrgroup.com">chuck@theptrgroup.com</a>=
&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On 07/12/2010 07:16 PM, F=
ushen Chen wrote:<br>
&gt; The DWC OTG driver module provides the initialization and cleanup<br>
&gt; entry points for the DWC OTG USB driver.<br>
&gt;<br>
&gt; Signed-off-by: Fushen Chen &lt;<a href=3D"mailto:fchen@apm.com">fchen@=
apm.com</a>&gt;<br>
&gt; Signed-off-by: Mark Miesfeld &lt;<a href=3D"mailto:mmiesfeld@apm.com">=
mmiesfeld@apm.com</a>&gt;<br>
&gt; ---<br>
<br>
</div>This reply is to the patch series, not just this 1/9 patch section.<b=
r>
<br>
Fushen, why did you pick and choose which fixes to incorporate from the Den=
x<br>
tree&#39;s version of the dwc_otg driver?<br>
<br>
I&#39;m not taking the time here to go through this multipart patch and che=
ck that<br>
you incorporated every fix, but I *did* randomly pick one fix that I made t=
o that<br>
driver, to see if you incorporated it, and it appears you did not.<br>
I would have expected that you would have incorporated the fixes that were =
made<br>
to this driver in the Denx tree.<br>
<br>
The one that I checked is in the data toggle error interrupt handling, in<b=
r>
handle_hc_chhltd_intr_dma() (see your 5/9 email in this patch series). =A0I=
t looks<br>
like you left out the fix I made to this logic that averts an interrupt sto=
rm.<br>
<br>
I assume that since I checked one particular fix, and it was missing from y=
our<br>
patch series, that there are likely more fixes you omitted. =A0Can you expl=
ain why<br>
you would leave this out, after Stefan asked you to incorporate the code ch=
anges<br>
made in the Denx tree&#39;s version of the driver?<br>
<font color=3D"#888888"><br>
Chuck<br>
</font><div><div></div><div class=3D"h5">__________________________________=
_____________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Feng Kan<br=
>
</div>

--00c09f83a2c605263c048b4cdd69--
