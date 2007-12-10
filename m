Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail51-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 37B7EDDE07
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Dec 2007 16:47:05 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C83AF0.13A95097"
Subject: RE: Xilinx ML310 Linux 2.6 PCI bridge
Date: Sun, 9 Dec 2007 21:46:57 -0800
References: <169c03cb0712082151k74e504bvc6e21bb57534ef28@mail.gmail.com><fa686aa40712082218k7e520e45q1266ecb4692b7dbb@mail.gmail.com><169c03cb0712090932y52cb2744p245cdeb0cccc2ff2@mail.gmail.com>
	<fa686aa40712091223x3efb1143kfd81277890fb74ae@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Jean-Samuel Chenard" <jsamch@macs.ece.mcgill.ca>
Message-Id: <20071210054659.D373C16006E@mail51-dub.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C83AF0.13A95097
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I would strongly recommend not spending a huge amount of time on the =
ml310.  The University program board is dirt cheap for universities, =
very well supported under Linux, using either secretlab.ca or =
git.xilinx.com and you won't spend your time getting PCI to place and =
route correctly, followed by figuring out how to get Linux to talk to it =
nicely.

If your lab can afford a bee2, then you should be able to afford one (or =
better yet, several) xupv2p's to go with it.

http://www.xilinx.com/univ/xupv2p.html

Steve

-----Original Message-----
From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
on behalf of Grant Likely
Sent: Sun 12/9/2007 12:23 PM
To: Jean-Samuel Chenard
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Xilinx ML310 Linux 2.6 PCI bridge
=20
On 12/9/07, Jean-Samuel Chenard <jsamch@macs.ece.mcgill.ca> wrote:
> On Dec 9, 2007 1:18 AM, Grant Likely <grant.likely@secretlab.ca> =
wrote:
> > On 12/8/07, Jean-Samuel Chenard <jsamch@macs.ece.mcgill.ca> wrote:
> > > Thanks to the valuable information provided by this discussion =
group and
> > > particularly by Grant Likely from Secret Lab Technologies, I was =
able to
> > > setup and run Linux 2.6 on my ML-310 development platform.
> >
> > Congratulations.  If you had to make any changes to get it to work
> > then please send me your patches.
>
> Thank you for the quick reply.

No problem.

>
> I will directly update Secret Lab's Wiki pages.  Those pages are the
> ones that got me going really quickly, so I will add a few of my
> observations directly on your pages so everyone can benefit.

Much appreciated; thank you!

> My real target is the control FPGA on a BEE2 box
> (http://bee2.eecs.berkeley.edu) and on that particular setup, the
> control FPGA is directly connected to an LXT971A Ethernet PHY, so I'll
> use the ethernet MAC from Xilinx.

Cool platform.  Yes, you should have much better luck with the EMAC
core.  The driver needs some work to be acceptable for mainline, but
it should be functional.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded



------_=_NextPart_001_01C83AF0.13A95097
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: Xilinx ML310 Linux 2.6 PCI bridge</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>I would strongly recommend not spending a huge amount =
of time on the ml310.&nbsp; The University program board is dirt cheap =
for universities, very well supported under Linux, using either =
secretlab.ca or git.xilinx.com and you won't spend your time getting PCI =
to place and route correctly, followed by figuring out how to get Linux =
to talk to it nicely.<BR>
<BR>
If your lab can afford a bee2, then you should be able to afford one (or =
better yet, several) xupv2p's to go with it.<BR>
<BR>
<A =
HREF=3D"http://www.xilinx.com/univ/xupv2p.html">http://www.xilinx.com/uni=
v/xupv2p.html</A><BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
on behalf of Grant Likely<BR>
Sent: Sun 12/9/2007 12:23 PM<BR>
To: Jean-Samuel Chenard<BR>
Cc: linuxppc-embedded@ozlabs.org<BR>
Subject: Re: Xilinx ML310 Linux 2.6 PCI bridge<BR>
<BR>
On 12/9/07, Jean-Samuel Chenard &lt;jsamch@macs.ece.mcgill.ca&gt; =
wrote:<BR>
&gt; On Dec 9, 2007 1:18 AM, Grant Likely =
&lt;grant.likely@secretlab.ca&gt; wrote:<BR>
&gt; &gt; On 12/8/07, Jean-Samuel Chenard =
&lt;jsamch@macs.ece.mcgill.ca&gt; wrote:<BR>
&gt; &gt; &gt; Thanks to the valuable information provided by this =
discussion group and<BR>
&gt; &gt; &gt; particularly by Grant Likely from Secret Lab =
Technologies, I was able to<BR>
&gt; &gt; &gt; setup and run Linux 2.6 on my ML-310 development =
platform.<BR>
&gt; &gt;<BR>
&gt; &gt; Congratulations.&nbsp; If you had to make any changes to get =
it to work<BR>
&gt; &gt; then please send me your patches.<BR>
&gt;<BR>
&gt; Thank you for the quick reply.<BR>
<BR>
No problem.<BR>
<BR>
&gt;<BR>
&gt; I will directly update Secret Lab's Wiki pages.&nbsp; Those pages =
are the<BR>
&gt; ones that got me going really quickly, so I will add a few of =
my<BR>
&gt; observations directly on your pages so everyone can benefit.<BR>
<BR>
Much appreciated; thank you!<BR>
<BR>
&gt; My real target is the control FPGA on a BEE2 box<BR>
&gt; (<A =
HREF=3D"http://bee2.eecs.berkeley.edu">http://bee2.eecs.berkeley.edu</A>)=
 and on that particular setup, the<BR>
&gt; control FPGA is directly connected to an LXT971A Ethernet PHY, so =
I'll<BR>
&gt; use the ethernet MAC from Xilinx.<BR>
<BR>
Cool platform.&nbsp; Yes, you should have much better luck with the =
EMAC<BR>
core.&nbsp; The driver needs some work to be acceptable for mainline, =
but<BR>
it should be functional.<BR>
<BR>
Cheers,<BR>
g.<BR>
<BR>
--<BR>
Grant Likely, B.Sc., P.Eng.<BR>
Secret Lab Technologies Ltd.<BR>
grant.likely@secretlab.ca<BR>
(403) 399-0195<BR>
_______________________________________________<BR>
Linuxppc-embedded mailing list<BR>
Linuxppc-embedded@ozlabs.org<BR>
<A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://oz=
labs.org/mailman/listinfo/linuxppc-embedded</A><BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C83AF0.13A95097--
