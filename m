Return-Path: <florian@mickler.org>
Received: from mx01.d-labs.de (ist.d-labs.de [213.239.218.44])
	by ozlabs.org (Postfix) with ESMTP id 6B788B6F9C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 18:04:21 +1100 (EST)
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170])
	by mx01.d-labs.de (Postfix) with ESMTPSA id 181417FDCE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Mar 2011 08:04:16 +0100 (CET)
Received: by pxi19 with SMTP id 19so397447pxi.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 09 Mar 2011 23:04:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1299728723.20104.148.camel@Joe-Laptop>
References: <1299200729.3630.52.camel@concordia>
	<1299202862-10682-1-git-send-email-nacc@us.ibm.com>
	<1299208016.3630.81.camel@concordia>
	<1299209359.4338.220.camel@Joe-Laptop>
	<1299712336.6272.22.camel@concordia>
	<1299716903.20104.134.camel@Joe-Laptop>
	<1299728121.6272.46.camel@concordia>
	<1299728723.20104.148.camel@Joe-Laptop>
Date: Thu, 10 Mar 2011 08:04:15 +0100
Message-ID: <AANLkTi=HgMt5q_8vyGdprXY570Vfh+yQbAL-TVGXVXVD@mail.gmail.com>
Subject: Re: [PATCH] powerpc: disable MSI using new interface if possible
From: Florian Mickler <florian@mickler.org>
To: Joe Perches <joe@perches.com>
Content-Type: multipart/alternative; boundary=000e0cd2bfca0bec2b049e1b7405
Cc: Florian Mickler <florian@mickler.org>, linuxppc-dev@lists.ozlabs.org,
	Nishanth Aravamudan <nacc@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd2bfca0bec2b049e1b7405
Content-Type: text/plain; charset=ISO-8859-1

Am 10.03.2011 04:50 schrieb "Joe Perches" <joe@perches.com>:
>
> On Thu, 2011-03-10 at 14:35 +1100, Michael Ellerman wrote:
> > On Wed, 2011-03-09 at 16:28 -0800, Joe Perches wrote:
> > > On Thu, 2011-03-10 at 10:12 +1100, Michael Ellerman wrote:
> > > > True my last patch may have been two years ago, but I _wrote the
entire
> > > > file_, and essentially no one else has ever touched it.
> > > > > If you don't like how it currently works, suggest
> > > > > improvements.
> > > > I think I was suggesting that I should be in that list :)
> > > $ ./scripts/get_maintainer.pl -f --git-blame
arch/powerpc/platforms/pseries/msi.c
> > > Benjamin Herrenschmidt <benh@kernel.crashing.org> (supporter:LINUX FOR
POWERPC...,commits:8/11=73%)
> > > Paul Mackerras <paulus@samba.org> (supporter:LINUX FOR
POWERPC...,commits:4/11=36%)
> > > Grant Likely <grant.likely@secretlab.ca> (maintainer:OPEN FIRMWARE
AND...)
> > > Michael Ellerman <michael@ellerman.id.au> (authored
lines:481/481=100%,commits:11/11=100%)
> > > Linas Vepstas <linas@austin.ibm.com> (commits:1/11=9%)
> > > linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC...)
> > > linux-kernel@vger.kernel.org (open list)
> > > devicetree-discuss@lists.ozlabs.org (open list:OPEN FIRMWARE AND...)
> > That's awesome. But it's not the default, so hardly anyone will ever use
> > it :)
>
> It's not the default for a few reasons:
>
> o It can take a _long_ time to run
> o Linus Torvalds is still the "author of record"
>  for all the files in the initial commit
> o For files with activity, it doesn't add very
>  much useful as old commit authors do also tend
>  to show up in the new commits.
> o It can show maintainers that are no longer
>  active.
>
Michael, maybe I'm missing something,  but why don't you have a MAINTAINERS
entry for that file? That would fix it for you.

Regards, Flo

--000e0cd2bfca0bec2b049e1b7405
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p><br>
Am 10.03.2011 04:50 schrieb &quot;Joe Perches&quot; &lt;<a href=3D"mailto:j=
oe@perches.com">joe@perches.com</a>&gt;:<br>
&gt;<br>
&gt; On Thu, 2011-03-10 at 14:35 +1100, Michael Ellerman wrote:<br>
&gt; &gt; On Wed, 2011-03-09 at 16:28 -0800, Joe Perches wrote:<br>
&gt; &gt; &gt; On Thu, 2011-03-10 at 10:12 +1100, Michael Ellerman wrote:<b=
r>
&gt; &gt; &gt; &gt; True my last patch may have been two years ago, but I _=
wrote the entire<br>
&gt; &gt; &gt; &gt; file_, and essentially no one else has ever touched it.=
<br>
&gt; &gt; &gt; &gt; &gt; If you don&#39;t like how it currently works, sugg=
est<br>
&gt; &gt; &gt; &gt; &gt; improvements.<br>
&gt; &gt; &gt; &gt; I think I was suggesting that I should be in that list =
:)<br>
&gt; &gt; &gt; $ ./scripts/<a href=3D"http://get_maintainer.pl">get_maintai=
ner.pl</a> -f --git-blame arch/powerpc/platforms/pseries/msi.c<br>
&gt; &gt; &gt; Benjamin Herrenschmidt &lt;<a href=3D"mailto:benh@kernel.cra=
shing.org">benh@kernel.crashing.org</a>&gt; (supporter:LINUX FOR POWERPC...=
,commits:8/11=3D73%)<br>
&gt; &gt; &gt; Paul Mackerras &lt;<a href=3D"mailto:paulus@samba.org">paulu=
s@samba.org</a>&gt; (supporter:LINUX FOR POWERPC...,commits:4/11=3D36%)<br>
&gt; &gt; &gt; Grant Likely &lt;<a href=3D"mailto:grant.likely@secretlab.ca=
">grant.likely@secretlab.ca</a>&gt; (maintainer:OPEN FIRMWARE AND...)<br>
&gt; &gt; &gt; Michael Ellerman &lt;<a href=3D"mailto:michael@ellerman.id.a=
u">michael@ellerman.id.au</a>&gt; (authored lines:481/481=3D100%,commits:11=
/11=3D100%)<br>
&gt; &gt; &gt; Linas Vepstas &lt;<a href=3D"mailto:linas@austin.ibm.com">li=
nas@austin.ibm.com</a>&gt; (commits:1/11=3D9%)<br>
&gt; &gt; &gt; <a href=3D"mailto:linuxppc-dev@lists.ozlabs.org">linuxppc-de=
v@lists.ozlabs.org</a> (open list:LINUX FOR POWERPC...)<br>
&gt; &gt; &gt; <a href=3D"mailto:linux-kernel@vger.kernel.org">linux-kernel=
@vger.kernel.org</a> (open list)<br>
&gt; &gt; &gt; <a href=3D"mailto:devicetree-discuss@lists.ozlabs.org">devic=
etree-discuss@lists.ozlabs.org</a> (open list:OPEN FIRMWARE AND...)<br>
&gt; &gt; That&#39;s awesome. But it&#39;s not the default, so hardly anyon=
e will ever use<br>
&gt; &gt; it :)<br>
&gt;<br>
&gt; It&#39;s not the default for a few reasons:<br>
&gt;<br>
&gt; o It can take a _long_ time to run<br>
&gt; o Linus Torvalds is still the &quot;author of record&quot;<br>
&gt; =A0for all the files in the initial commit<br>
&gt; o For files with activity, it doesn&#39;t add very<br>
&gt; =A0much useful as old commit authors do also tend<br>
&gt; =A0to show up in the new commits.<br>
&gt; o It can show maintainers that are no longer<br>
&gt; =A0active.<br>
&gt;<br>
Michael, maybe I&#39;m missing something,=A0 but why don&#39;t you have a M=
AINTAINERS entry for that file? That would fix it for you.</p>
<p>Regards, Flo</p>

--000e0cd2bfca0bec2b049e1b7405--
