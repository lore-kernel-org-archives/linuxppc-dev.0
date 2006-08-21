Return-Path: <wmaxfield@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id 6D2D367C32
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 02:12:53 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c2so2070157nfe
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Aug 2006 09:12:51 -0700 (PDT)
Message-ID: <45a1b53e0608210912n437ac62eo6a838424c59e88d2@mail.gmail.com>
Date: Mon, 21 Aug 2006 11:12:37 -0500
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Fwd: PPC beginner questions
In-Reply-To: <45a1b53e0608210717r1ea48761hc733983bd02512fb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_42001_10957270.1156176757639"
References: <1CFEB358338412458B21FAA0D78FE86D057F4C51@rennsmail02.eu.thmulti.com>
	<45a1b53e0608210717r1ea48761hc733983bd02512fb@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_42001_10957270.1156176757639
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

  Thanks!  I'd already seen the #1 (#2) link in the FAQ and understood
that.  I'm not doing this from userland, so I was assuming it did not apply=
,
although I was going to use it to play with in user space.

  The #3 comes up as an error for me, the lists.linuxppc.org domain name
does not resolve.  Several other links in the FAQ do not resolve properly.
One now points to a page that has paid links to other pages.


thanks again,
Wade



On 8/21/06, Fillod Stephane <stephane.fillod@thomson.net> wrote:
>
>  Your question is a linuxppc-embedded FAQ. User-land access
>
> is documented in Denx's FAQ[1], and accessible through shorter URL[2].
>
> For more information, please follow this thread[3] (not ppc specific
> actually).
>
>
>
> [1]
> http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Acces=
singPeripheralsFromUserSpace
>
> [2] http://tinyurl.com/6c7th
>
> [3] http://lists.linuxppc.org/linuxppc-embedded/200403/msg00059.html
>
>
>
> In kernel land, ioremap() is all you need.
>
>
>
> Don't forget to use the 'eieio' asm instruction if you want explicit I/O
> ordering.
>
>
>
> Regards,
>
> --
>
> Stephane
>
>
>
>
>  ------------------------------
>
> *Envoy=E9 :* lundi 21 ao=FBt 2006 15:51
> *Objet :* PPC beginner questions
>
>
>
>
>   I'm new to the PPC and I have a few questions.  I have written a  drive=
r
> in the past for the X86 family, using i/o ports, but it was kernel 2.0 an=
d
> i/o ports are not mmu handled.
>   I've been looking through the archive and I am slowly growing more
> confused.
>
>   We are using Xilinx with PPC built in.
>
>    The PPC has a memory management unit.  All of the IP we've added is
> mapped to physical addresses.
>
>    1. Can I access the memory the peripherasl are mapped to directly
> within the driver without going through functions?
>        if NOT, then Do I use
>           1. ioremap(),
>           2. request_mem_region(),
>           3. request_region()
>           4. something else?
>
>    2.  Are there any gotcha's with the ppc 405 that Xilinx uses that I
> should know about?
>
>
> thanks,
> wade
>
>
>

------=_Part_42001_10957270.1156176757639
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<span class=3D"gmail_quote"><br></span><div><br>&nbsp; Thanks!&nbsp; I'd al=
ready seen the #1 (#2) link in the FAQ and understood that.&nbsp; I'm not d=
oing this from userland, so I was assuming it did not apply, although I was=
 going to use it to play with in user space.=20
<br><br>&nbsp; The #3 comes up as an error for me, the=20
<a href=3D"http://lists.linuxppc.org" target=3D"_blank" onclick=3D"return t=
op.js.OpenExtLink(window,event,this)">lists.linuxppc.org</a> domain name do=
es not resolve.&nbsp; Several other links in the FAQ do not resolve properl=
y. One now points to a page that has paid links to other pages.=20
<br><br><br>thanks again,<br></div><div><span class=3D"sg">Wade</span></div=
><div><span class=3D"e" id=3D"q_10d3117a7bd021ba_2"><br>&nbsp;&nbsp; <br><b=
r><div><span class=3D"gmail_quote">On 8/21/06, <b class=3D"gmail_sendername=
">Fillod Stephane
</b> &lt;<a href=3D"mailto:stephane.fillod@thomson.net" target=3D"_blank" o=
nclick=3D"return top.js.OpenExtLink(window,event,this)">stephane.fillod@tho=
mson.net</a>&gt; wrote:
</span><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rg=
b(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div>









<div link=3D"blue" vlink=3D"#606420" lang=3D"FR">

<div>

<p><font face=3D"Courier New" size=3D"2"><span style=3D"font-size: 10pt;" l=
ang=3D"EN-GB">Your question is
a linuxppc-embedded FAQ. User-land access</span></font></p>

<p><font face=3D"Courier New" size=3D"2"><span style=3D"font-size: 10pt;" l=
ang=3D"EN-GB">is documented in
Denx's FAQ[1], and accessible through shorter URL[2].</span></font></p>

<p><font face=3D"Courier New" size=3D"2"><span style=3D"font-size: 10pt;" l=
ang=3D"EN-GB">For more
information, please follow this thread[3] (not ppc specific actually).</spa=
n></font></p>

<p><font face=3D"Courier New" size=3D"2"><span style=3D"font-size: 10pt;" l=
ang=3D"EN-GB">&nbsp;</span></font></p>

<p><font face=3D"Courier New" size=3D"2"><span style=3D"font-size: 10pt;" l=
ang=3D"EN-GB">[1] </span></font><font face=3D"Courier New" size=3D"2"><span=
 style=3D"font-size: 10pt;"><a href=3D"http://www.denx.de/twiki/bin/view/PP=
CEmbedded/DeviceDrivers#Section_AccessingPeripheralsFromUserSpace" target=
=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">

<span lang=3D"EN-GB">http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDr=
ivers#Section_AccessingPeripheralsFromUserSpace</span></a></span></font><fo=
nt face=3D"Courier New" size=3D"2"><span style=3D"font-size: 10pt;" lang=3D=
"EN-GB">

</span></font></p>

<p><font face=3D"Courier New" size=3D"2"><span style=3D"font-size: 10pt;" l=
ang=3D"EN-GB">[2] </span></font><font face=3D"Courier New" size=3D"2"><span=
 style=3D"font-size: 10pt;"><a href=3D"http://tinyurl.com/6c7th" target=3D"=
_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">

<span lang=3D"EN-GB">http://tinyurl.com/6c7th</span></a></span></font><font=
 face=3D"Courier New" size=3D"2"><span style=3D"font-size: 10pt;" lang=3D"E=
N-GB"></span></font></p>

<p><font face=3D"Courier New" size=3D"2"><span style=3D"font-size: 10pt;" l=
ang=3D"EN-GB">[3] </span></font><font face=3D"Courier New" size=3D"2"><span=
 style=3D"font-size: 10pt;"><a href=3D"http://lists.linuxppc.org/linuxppc-e=
mbedded/200403/msg00059.html" target=3D"_blank" onclick=3D"return top.js.Op=
enExtLink(window,event,this)">

<span lang=3D"EN-GB">http://lists.linuxppc.org/linuxppc-embedded/200403/msg=
00059.html</span></a></span></font><font face=3D"Courier New" size=3D"2"><s=
pan style=3D"font-size: 10pt;" lang=3D"EN-GB"></span></font></p>

<p><font face=3D"Courier New" size=3D"2"><span style=3D"font-size: 10pt;" l=
ang=3D"EN-GB">&nbsp;</span></font></p>

<p><font face=3D"Courier New" size=3D"2"><span style=3D"font-size: 10pt;" l=
ang=3D"EN-GB">In kernel land,
ioremap() is all you need.</span></font></p>

<p><font face=3D"Courier New" size=3D"2"><span style=3D"font-size: 10pt;" l=
ang=3D"EN-GB">&nbsp;</span></font></p>

<p><font face=3D"Courier New" size=3D"2"><span style=3D"font-size: 10pt;" l=
ang=3D"EN-GB">Don't
forget to use the 'eieio' asm instruction if you want explicit I/O
ordering.</span></font></p>

<p><font face=3D"Courier New" size=3D"2"><span style=3D"font-size: 10pt;" l=
ang=3D"EN-GB">&nbsp;</span></font></p>

<p><font face=3D"Courier New" size=3D"2"><span style=3D"font-size: 10pt;">R=
egards,</span></font></p>

<p><font face=3D"Courier New" size=3D"2"><span style=3D"font-size: 10pt;">-=
- </span></font></p>

<p><font face=3D"Courier New" size=3D"2"><span style=3D"font-size: 10pt;">S=
tephane</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<p><font color=3D"navy" face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial; color: navy;">&nbsp;</span></font></p>

<div>

<div style=3D"text-align: center;" align=3D"center"><font face=3D"Times New=
 Roman" size=3D"3"><span style=3D"font-size: 12pt;">

<hr align=3D"center" size=3D"2" width=3D"100%">

</span></font></div>

<p><b><font face=3D"Tahoma" size=3D"2"><span style=3D"font-size: 10pt; font=
-family: Tahoma; font-weight: bold;">Envoy=E9&nbsp;:</span></font></b><font=
 face=3D"Tahoma" size=3D"2"><span style=3D"font-size: 10pt; font-family: Ta=
homa;"> lundi 21
ao=FBt 2006 15:51<br>
<b><span style=3D"font-weight: bold;">Objet&nbsp;:</span></b> PPC beginner
questions</span></font></p>

</div>

<p><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size: 12pt=
;">&nbsp;</span></font></p>

<p><font face=3D"Times New Roman" size=3D"3"><span style=3D"font-size: 12pt=
;"><br>
&nbsp; I'm new to the PPC and I have a few questions.&nbsp; I have written
a&nbsp; driver in the past for the X86 family, using i/o ports, but it was
kernel 2.0 and i/o ports are not mmu handled.<br>
&nbsp; I've been looking through the archive and I am slowly growing more
confused. <br>
<br>
&nbsp; We are using Xilinx with PPC built in.<br>
<br>
&nbsp;&nbsp; The PPC has a memory management unit.&nbsp; All of the IP we'v=
e
added is mapped to physical addresses.<br>
<br>
&nbsp;&nbsp; 1. Can I access the memory the peripherasl are mapped to direc=
tly
within the driver without going through functions? <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if NOT, then Do I use <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1. ioremap(), <br>
&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; 2. request_mem_region(), <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3. request_region()<=
br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 4. something else?<br>
<br>
&nbsp;&nbsp; 2.&nbsp; Are there any gotcha's with the ppc 405 that Xilinx u=
ses
that I should know about? <br>
<br>
<br>
thanks,<br>
wade<br>
<br>
&nbsp;</span></font></p>

</div>

</div>



</div></blockquote></div><br>

</span></div>

------=_Part_42001_10957270.1156176757639--
