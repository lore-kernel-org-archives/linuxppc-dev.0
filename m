Return-Path: <cymraegish@gmail.com>
Received: from mail-px0-f184.google.com (mail-px0-f184.google.com
	[209.85.216.184]) by ozlabs.org (Postfix) with ESMTP id 00264B7BB4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Sep 2009 14:13:34 +1000 (EST)
Received: by pxi14 with SMTP id 14so6789816pxi.3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Sep 2009 21:13:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.64.0909261949240.4273@axis700.grange>
References: <0046254A-432D-4AE3-9B9F-C0D30311B7D7@codex.gr>
	<Pine.LNX.4.64.0909261949240.4273@axis700.grange>
Date: Mon, 28 Sep 2009 20:46:37 -0700
Message-ID: <b19c9ba70909282046g1bdfa920v632c389a99fb46a0@mail.gmail.com>
Subject: Re: Market research for new PowerPC system
From: Brian Morris <cymraegish@gmail.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Content-Type: multipart/alternative; boundary=000e0cd157eee959b30474af421a
Cc: Konstantinos Margaritis <markos@codex.gr>, debian-powerpc@lists.debian.org,
	linuxppc-dev@lists.ozlabs.org, opensuse-ppc@opensuse.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd157eee959b30474af421a
Content-Type: text/plain; charset=ISO-8859-1

I think that you should start out with something of the sub-netbook type.
These are the next generation and coming up very soon. For a home computer
you need at least dual core and at those speeds it will need a very low
price and small footprint.
If you could sneak in on the sub-net quick perhaps power could become 2nd to
ARM as AMD is to Intel. Intel is trying to sneak in but there could be some
anti-trust issues, especially if there are other contenders (maybe).

Its really too too bad PA-SEMI killed by apple last year. I am still mad
about that. That was a really really nice cpu, 2ghz and 7watt and 64bit.
Should have been illegal.

The  first subnetbook  may likely be an apple product, and a tablet with an
optional separate keyboard and a 9.5 inch screen, and the ARM cpu...



On Sat, Sep 26, 2009 at 10:58 AM, Guennadi Liakhovetski <
g.liakhovetski@gmx.de> wrote:

> On Sat, 26 Sep 2009, Konstantinos Margaritis wrote:
>
> > (Sorry for the cross-posting, please ignore if you are not interested in
> this,
> > CC me as I'm not subscribed)
> > Hi,
> >
> > First some introductions. I'm Konstantinos Margaritis, a long time
> > Amiga/BeOS/Linux user/developer and a PowerPC fan, former Debian
> Developer,
> > also a SIMD/AltiVec fanatic and the author of libfreevec. I've posted
> this on
> > the following sites:
> >
> >
> http://amigaworld.net/modules/newbb/viewtopic.php?mode=viewtopic&topic_id=29594&forum=33&start=0&viewmode=flat&order=0
> >
> > http://www.amiga.org/forums/showthread.php?t=49424
> >
> >
> http://www.morphzone.org/modules/newbb_plus/viewtopic.php?topic_id=6465&forum=11
> >
> >
> http://aros-exec.org/modules/newbb/viewtopic.php?viewmode=flat&topic_id=3768&forum=4
> >
> >
> http://www.haiku-os.org/community/forum/market_research_new_powerpc_system#comment-12604
> >
> > To anyone who is not a PowerPC user, it might seem like crazy, but here
> it
> > goes:
> >
> > I'm considering funding the design & production of a new PowerPC system
> (well,
> > the motherboard, the rest are typical pc stuff and a case). No this is
> not a
> > joke, I've been wanting to do this for a long time, and perhaps the
> chance
> > will be given to me now. But before I spend any money on this, I want to
> do a
> > little market research first. I know the market is literally "dying" for
> a new
> > powerpc motherboard, but exactly how many are there that want to buy one?
>
> Ok, just a short comment. In principle I like diversity, competition, etc.
> And it was somewhat sad when Apple abandoned ppc. But honestly - why
> should I be buying a ppc desktop system? If we restrict our comparison to
> Linux, because that's what I'm using, what advantages would a ppc system
> give me over a comparable in price ix86 system? This is not meant
> negatively, I just have not followed recent ppc CPUs from the "desktop"
> range, so, this is a real honest question. Would such a system provide
> more MIPS per Watt at the same price? Or more periferals? Or some specific
> hardware blocks unavailable or unsupported om ix86?
>
> Thanks
> Guennadi
>
> >
> > Ok, let's give some rough specs first. I'm considering 3 choices -not in
> order
> > of probability/importance:
> >
> > 1. MPC8640D-based. It will be dual core at 1Ghz -most likely, higher
> > frequencies are much more expensive and the cost of the final board would
> be
> > prohibitive.
> > 2. MPC8610-based. Single core at 1Ghz, slightly less expensive, and
> includes a
> > 2D DIU display unit -quite fast, but no 3D unfortunately.
> > 3. QorIQ P1022-based. Again dual core at 1Ghz (1055Mhz to be precise).
> Apart
> > from the much lower chip price, this one includes dual gigabit ethernet,
> dual
> > SATA, USB 2.0 and a 2D DIU display unit (same as the MPC8610). So this
> one
> > would lower the cost of the board quite much. Disadvantages: No AltiVec
> unit
> > (it sucks I know), though it includes an SPE unit which is not that bad,
> and
> > availability will be in Q3/Q4 2010, so that's a long wait.
> >
> > Now, the end motherboard will probably be MicroATX (in the 8640D/8610
> case) or
> > PicoITX (in the P1022 case), and it will definitely include:
> >
> > * SATA connectors
> > * USB (possibly 2 back and 2 front, but that's discussable)
> > * Dual gigabit (at least one will be there, in the case of the MPC8640D
> we
> > might even have 4!!!)
> > * Sound (of course, SPDIF support will definitely be there)
> > * 1 PCI-e slot 1x
> > * 1 PCI-e slot (4x in the P1022 case, 8x in the MPC86xx cases)
> >
> > Ok, what I want to know is if people would really really buy one of
> these. End
> > price is estimated to be ~around~ 350EUR for the P1022 board or ~500EUR
> > (definitely more in the case of 8640D) in the case of the other boards.
> > Besides being more expensive, the MPC86xx chips, don't include SATA, USB
> and
> > only one of ethernet/sound (quad-gige in MPC8640D case, or sound in the
> case
> > of MPC8610). I know this sounds a lot, but it's the reality, there is not
> > enough funding to build enormous amounts of units and bring the prices
> down
> > substantially, we have to start low and build up from there. In case you
> are
> > wondering, yes, the boards will be designed/produced by bPlan and funded
> by my
> > company (Codex).
> >
> > Support for OSes: Linux definitely, Haiku most probably and there is a
> > possibility of supporting AmigaOS/MorphOS, which will depend on the
> actual
> > feedback I get from those users.
> >
> > I would like to make a list of everyone that is really interested in such
> a
> > system, so it would really help me make a decision sooner rather than
> later if
> > you would send me a few personal details to markos@codex.gr with subject
> > "PowerPC board":
> >
> > * Name
> > * Country
> > * email (definitely, I'd have to reach you back!)
> > * Phone/Skype (optional, please include international prefix)
> > * Forum you saw this post (ok, Morphzone in this case)
> > * OS of preference
> > * board you would be most interested in (MPC8610/MPC8640D/P1022)
> > * preferred price (please have in mind the estimated price quotes I
> mentioned,
> > it might be lower but that's not very probable)
> > * Other notes/comments
> >
> > Also, I found out that I had to state my case on many forums to prove
> that
> > this is not vapourware. Well, it will not be vapourware, if I get
> feedback. So
> > far the feedback I got can be summarized here:
> >
> > http://www.codex.gr/index.php?pageID=&blogItem=60
> >
> > Thanks a lot for your time and I hope this system becomes a reality.
> >
> > Konstantinos Margaritis
> >
> > Codex
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>
>
> --
> To UNSUBSCRIBE, email to debian-powerpc-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact
> listmaster@lists.debian.org
>
>

--000e0cd157eee959b30474af421a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I think that you should start out with something of the sub-netbook type. T=
hese are the next generation and coming up very soon. For a home computer y=
ou need at least dual core and at those speeds it will need a very low pric=
e and small footprint.<div>
<br></div><div>If you could sneak in on the sub-net quick perhaps power cou=
ld become 2nd to ARM as AMD is to Intel. Intel is trying to sneak in but th=
ere could be some anti-trust issues, especially if there are other contende=
rs (maybe).</div>
<div><br></div><div>Its really too too bad PA-SEMI killed by apple last yea=
r. I am still mad about that. That was a really really nice cpu, 2ghz and 7=
watt and 64bit. Should have been illegal.</div><div><br></div><div>The =A0f=
irst subnetbook =A0may likely be an apple product, and a tablet with an opt=
ional separate keyboard and a 9.5 inch screen, and the ARM cpu...</div>
<div><br></div><div><br><br><div class=3D"gmail_quote">On Sat, Sep 26, 2009=
 at 10:58 AM, Guennadi Liakhovetski <span dir=3D"ltr">&lt;<a href=3D"mailto=
:g.liakhovetski@gmx.de">g.liakhovetski@gmx.de</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex;">
On Sat, 26 Sep 2009, Konstantinos Margaritis wrote:<br>
<br>
&gt; (Sorry for the cross-posting, please ignore if you are not interested =
in this,<br>
&gt; CC me as I&#39;m not subscribed)<br>
&gt; Hi,<br>
&gt;<br>
&gt; First some introductions. I&#39;m Konstantinos Margaritis, a long time=
<br>
&gt; Amiga/BeOS/Linux user/developer and a PowerPC fan, former Debian Devel=
oper,<br>
&gt; also a SIMD/AltiVec fanatic and the author of libfreevec. I&#39;ve pos=
ted this on<br>
&gt; the following sites:<br>
&gt;<br>
&gt; <a href=3D"http://amigaworld.net/modules/newbb/viewtopic.php?mode=3Dvi=
ewtopic&amp;topic_id=3D29594&amp;forum=3D33&amp;start=3D0&amp;viewmode=3Dfl=
at&amp;order=3D0" target=3D"_blank">http://amigaworld.net/modules/newbb/vie=
wtopic.php?mode=3Dviewtopic&amp;topic_id=3D29594&amp;forum=3D33&amp;start=
=3D0&amp;viewmode=3Dflat&amp;order=3D0</a><br>

&gt;<br>
&gt; <a href=3D"http://www.amiga.org/forums/showthread.php?t=3D49424" targe=
t=3D"_blank">http://www.amiga.org/forums/showthread.php?t=3D49424</a><br>
&gt;<br>
&gt; <a href=3D"http://www.morphzone.org/modules/newbb_plus/viewtopic.php?t=
opic_id=3D6465&amp;forum=3D11" target=3D"_blank">http://www.morphzone.org/m=
odules/newbb_plus/viewtopic.php?topic_id=3D6465&amp;forum=3D11</a><br>
&gt;<br>
&gt; <a href=3D"http://aros-exec.org/modules/newbb/viewtopic.php?viewmode=
=3Dflat&amp;topic_id=3D3768&amp;forum=3D4" target=3D"_blank">http://aros-ex=
ec.org/modules/newbb/viewtopic.php?viewmode=3Dflat&amp;topic_id=3D3768&amp;=
forum=3D4</a><br>

&gt;<br>
&gt; <a href=3D"http://www.haiku-os.org/community/forum/market_research_new=
_powerpc_system#comment-12604" target=3D"_blank">http://www.haiku-os.org/co=
mmunity/forum/market_research_new_powerpc_system#comment-12604</a><br>
&gt;<br>
&gt; To anyone who is not a PowerPC user, it might seem like crazy, but her=
e it<br>
&gt; goes:<br>
&gt;<br>
&gt; I&#39;m considering funding the design &amp; production of a new Power=
PC system (well,<br>
&gt; the motherboard, the rest are typical pc stuff and a case). No this is=
 not a<br>
&gt; joke, I&#39;ve been wanting to do this for a long time, and perhaps th=
e chance<br>
&gt; will be given to me now. But before I spend any money on this, I want =
to do a<br>
&gt; little market research first. I know the market is literally &quot;dyi=
ng&quot; for a new<br>
&gt; powerpc motherboard, but exactly how many are there that want to buy o=
ne?<br>
<br>
Ok, just a short comment. In principle I like diversity, competition, etc.<=
br>
And it was somewhat sad when Apple abandoned ppc. But honestly - why<br>
should I be buying a ppc desktop system? If we restrict our comparison to<b=
r>
Linux, because that&#39;s what I&#39;m using, what advantages would a ppc s=
ystem<br>
give me over a comparable in price ix86 system? This is not meant<br>
negatively, I just have not followed recent ppc CPUs from the &quot;desktop=
&quot;<br>
range, so, this is a real honest question. Would such a system provide<br>
more MIPS per Watt at the same price? Or more periferals? Or some specific<=
br>
hardware blocks unavailable or unsupported om ix86?<br>
<br>
Thanks<br>
Guennadi<br>
<br>
&gt;<br>
&gt; Ok, let&#39;s give some rough specs first. I&#39;m considering 3 choic=
es -not in order<br>
&gt; of probability/importance:<br>
&gt;<br>
&gt; 1. MPC8640D-based. It will be dual core at 1Ghz -most likely, higher<b=
r>
&gt; frequencies are much more expensive and the cost of the final board wo=
uld be<br>
&gt; prohibitive.<br>
&gt; 2. MPC8610-based. Single core at 1Ghz, slightly less expensive, and in=
cludes a<br>
&gt; 2D DIU display unit -quite fast, but no 3D unfortunately.<br>
&gt; 3. QorIQ P1022-based. Again dual core at 1Ghz (1055Mhz to be precise).=
 Apart<br>
&gt; from the much lower chip price, this one includes dual gigabit etherne=
t, dual<br>
&gt; SATA, USB 2.0 and a 2D DIU display unit (same as the MPC8610). So this=
 one<br>
&gt; would lower the cost of the board quite much. Disadvantages: No AltiVe=
c unit<br>
&gt; (it sucks I know), though it includes an SPE unit which is not that ba=
d, and<br>
&gt; availability will be in Q3/Q4 2010, so that&#39;s a long wait.<br>
&gt;<br>
&gt; Now, the end motherboard will probably be MicroATX (in the 8640D/8610 =
case) or<br>
&gt; PicoITX (in the P1022 case), and it will definitely include:<br>
&gt;<br>
&gt; * SATA connectors<br>
&gt; * USB (possibly 2 back and 2 front, but that&#39;s discussable)<br>
&gt; * Dual gigabit (at least one will be there, in the case of the MPC8640=
D we<br>
&gt; might even have 4!!!)<br>
&gt; * Sound (of course, SPDIF support will definitely be there)<br>
&gt; * 1 PCI-e slot 1x<br>
&gt; * 1 PCI-e slot (4x in the P1022 case, 8x in the MPC86xx cases)<br>
&gt;<br>
&gt; Ok, what I want to know is if people would really really buy one of th=
ese. End<br>
&gt; price is estimated to be ~around~ 350EUR for the P1022 board or ~500EU=
R<br>
&gt; (definitely more in the case of 8640D) in the case of the other boards=
.<br>
&gt; Besides being more expensive, the MPC86xx chips, don&#39;t include SAT=
A, USB and<br>
&gt; only one of ethernet/sound (quad-gige in MPC8640D case, or sound in th=
e case<br>
&gt; of MPC8610). I know this sounds a lot, but it&#39;s the reality, there=
 is not<br>
&gt; enough funding to build enormous amounts of units and bring the prices=
 down<br>
&gt; substantially, we have to start low and build up from there. In case y=
ou are<br>
&gt; wondering, yes, the boards will be designed/produced by bPlan and fund=
ed by my<br>
&gt; company (Codex).<br>
&gt;<br>
&gt; Support for OSes: Linux definitely, Haiku most probably and there is a=
<br>
&gt; possibility of supporting AmigaOS/MorphOS, which will depend on the ac=
tual<br>
&gt; feedback I get from those users.<br>
&gt;<br>
&gt; I would like to make a list of everyone that is really interested in s=
uch a<br>
&gt; system, so it would really help me make a decision sooner rather than =
later if<br>
&gt; you would send me a few personal details to <a href=3D"mailto:markos@c=
odex.gr">markos@codex.gr</a> with subject<br>
&gt; &quot;PowerPC board&quot;:<br>
&gt;<br>
&gt; * Name<br>
&gt; * Country<br>
&gt; * email (definitely, I&#39;d have to reach you back!)<br>
&gt; * Phone/Skype (optional, please include international prefix)<br>
&gt; * Forum you saw this post (ok, Morphzone in this case)<br>
&gt; * OS of preference<br>
&gt; * board you would be most interested in (MPC8610/MPC8640D/P1022)<br>
&gt; * preferred price (please have in mind the estimated price quotes I me=
ntioned,<br>
&gt; it might be lower but that&#39;s not very probable)<br>
&gt; * Other notes/comments<br>
&gt;<br>
&gt; Also, I found out that I had to state my case on many forums to prove =
that<br>
&gt; this is not vapourware. Well, it will not be vapourware, if I get feed=
back. So<br>
&gt; far the feedback I got can be summarized here:<br>
&gt;<br>
&gt; <a href=3D"http://www.codex.gr/index.php?pageID=3D&amp;blogItem=3D60" =
target=3D"_blank">http://www.codex.gr/index.php?pageID=3D&amp;blogItem=3D60=
</a><br>
&gt;<br>
&gt; Thanks a lot for your time and I hope this system becomes a reality.<b=
r>
&gt;<br>
&gt; Konstantinos Margaritis<br>
&gt;<br>
&gt; Codex<br>
&gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; <a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.oz=
labs.org</a><br>
&gt; <a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_=
blank">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
<br>
---<br>
Guennadi Liakhovetski, Ph.D.<br>
Freelance Open-Source Software Developer<br>
<a href=3D"http://www.open-technology.de/" target=3D"_blank">http://www.ope=
n-technology.de/</a><br>
<font color=3D"#888888"><br>
<br>
--<br>
To UNSUBSCRIBE, email to <a href=3D"mailto:debian-powerpc-REQUEST@lists.deb=
ian.org">debian-powerpc-REQUEST@lists.debian.org</a><br>
with a subject of &quot;unsubscribe&quot;. Trouble? Contact <a href=3D"mail=
to:listmaster@lists.debian.org">listmaster@lists.debian.org</a><br>
<br>
</font></blockquote></div><br></div>

--000e0cd157eee959b30474af421a--
