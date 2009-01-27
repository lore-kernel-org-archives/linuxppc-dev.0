Return-Path: <rgubler@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 95CD4DE002
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 09:16:00 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so2509771ywh.39
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 14:15:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090126232028.GB10495@yookeroo.seuss>
References: <e4ef24880901231707y7baad5f6kc1f6bde2c30bf29f@mail.gmail.com>
	<20090124014701.71561832E425@gemini.denx.de>
	<20090126232028.GB10495@yookeroo.seuss>
Date: Tue, 27 Jan 2009 14:15:58 -0800
Message-ID: <e4ef24880901271415q166a20e0m53d495c3dc2f80a3@mail.gmail.com>
Subject: Re: Ebony DTS compile error
From: Rob Gubler <rgubler@gmail.com>
To: Wolfgang Denk <wd@denx.de>, Rob Gubler <rgubler@gmail.com>,
	linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cd328722248e004617e33ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd328722248e004617e33ca
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

>
> > > Is anyone aware of a version of DTC that will compile the ebony.dts
> file
> > > included with the 2.6.24 kernel?  Or, an updated ebony.dts file that
> works
> > > with DTC 1.2.0-gb2b4990b.  Any other suggestions would be great.
>  Thanks!
> >
> > Is there any specific reson for you to use the old 2.6.24 kernel?
> >
> > If not, I'd recommend that you clone the git repository and use recent
> > code - this will build fine with current versions of the dtc.
>
> I concur.  If you really have to use the old kernel, you could
> manually update the dts to dts-v1 without making other changes, which
> should be relatively simple - that's just a matter of changing all
> numbers in the file from bare hex to C-style (decimal by default, 0x
> for hex, etc.) and adding the magic /dts-v1/ tag at the top.



My only attachment to this kernel is it looks like the IPIPE and Xenomai
patches have already been applied to the 2.6.24 kernel provided by ELDK
4.2.  In the past applying these patches for an x86 machine wasn't always a
simple task.  I was hoping to save myself some time.

What git URL / path do you recommend I use to clone the repository?  I found
some instructions on rebuilding the ELDK from scratch (
http://www.denx.de/wiki/view/DULG/ELDKRebuilding).   Are these the
instructions I should be following?

 -Rob

--000e0cd328722248e004617e33ca
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"borde=
r-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-le=
ft: 1ex;">&gt; &gt; Is anyone aware of a version of DTC that will compile t=
he ebony.dts file<br>
<div class=3D"Ih2E3d">
&gt; &gt; included with the 2.6.24 kernel? &nbsp;Or, an updated ebony.dts f=
ile that works<br>
&gt; &gt; with DTC 1.2.0-gb2b4990b. &nbsp;Any other suggestions would be gr=
eat. &nbsp;Thanks!<br>
&gt;<br>
&gt; Is there any specific reson for you to use the old 2.6.24 kernel?<br>
&gt;<br>
&gt; If not, I&#39;d recommend that you clone the git repository and use re=
cent<br>
&gt; code - this will build fine with current versions of the dtc.<br>
<br>
</div>I concur. &nbsp;If you really have to use the old kernel, you could<b=
r>
manually update the dts to dts-v1 without making other changes, which<br>
should be relatively simple - that&#39;s just a matter of changing all<br>
numbers in the file from bare hex to C-style (decimal by default, 0x<br>
for hex, etc.) and adding the magic /dts-v1/ tag at the top.</blockquote><d=
iv><br><br>My only attachment to this kernel is it looks like the IPIPE and=
 Xenomai patches have already been applied to the 2.6.24 kernel provided by=
 ELDK 4.2.&nbsp; In the past applying these patches for an x86 machine wasn=
&#39;t always a simple task.&nbsp; I was hoping to save myself some time. <=
br>
<br>What git URL / path do you recommend I use to clone the repository?&nbs=
p; I found some instructions on rebuilding the ELDK from scratch (<a href=
=3D"http://www.denx.de/wiki/view/DULG/ELDKRebuilding">http://www.denx.de/wi=
ki/view/DULG/ELDKRebuilding</a>). &nbsp; Are these the instructions I shoul=
d be following?&nbsp; <br>
<br>&nbsp;-Rob<br></div></div><br><br><br>

--000e0cd328722248e004617e33ca--
