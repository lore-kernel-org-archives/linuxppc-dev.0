Return-Path: <mchollin@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgKQD0pZDzDq65
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 07:59:47 +1000 (AEST)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mchollin@us.ibm.com>;
 Wed, 6 Apr 2016 15:59:46 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id EE3823E4001C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 15:59:43 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u36LxhVv42926092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 14:59:43 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u36LxfGM026617
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 15:59:42 -0600
Received: from e39.co.us.ibm.com (e39.boulder.ibm.com [9.17.249.49])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u36LxdvW026389
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 15:59:39 -0600
Message-Id: <201604062159.u36LxdvW026389@d03av02.boulder.ibm.com>
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mchollin@us.ibm.com>;
 Wed, 6 Apr 2016 15:59:39 -0600
Received: from /spool/local
 by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
 for <linuxppc-dev@lists.ozlabs.org> from <mchollin@us.ibm.com>;
 Wed, 6 Apr 2016 21:59:35 -0000
In-Reply-To: <570584EF.1010904@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] powerpc/pci: Assign fixed PHB number based on
 device-tree properties
From: "Michael C Hollinger" <mchollin@us.ibm.com>
To: gpiccoli@linux.vnet.ibm.com
Cc: "Andrew Donnellan - LTC" <andrew.donnellan@au1.ibm.com>,
 bhelgaas@google.com, "Frederic Barrat" <frederic.barrat@fr.ibm.com>,
 gwshan@linux.vnet.ibm.com, "Ian Munsie - LTC" <imunsie@au1.ibm.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Manoj Kumar"
 <kumarmn@us.ibm.com>, mikey@neuling.org,
 mpe@ellerman.id.au, mrochs@linux.vnet.ibm.com, paulus@samba.org
Date: Wed, 6 Apr 2016 21:59:33 +0000
MIME-Version: 1.0
References: <570584EF.1010904@linux.vnet.ibm.com>,
 <1458337746-20337-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1459971134-sup-6269@x230.ozlabs.ibm.com>
Content-Type: multipart/related; boundary="=_related 0078CF1D00257F8D_="
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=_related 0078CF1D00257F8D_=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<div class=3D"socmaildefaultfont" dir=3D"ltr" style=3D"font-family:Arial;fo=
nt-size:10.5pt" ><div dir=3D"ltr" style=3D"font-family:Arial;font-size:10.5=
pt" ><div dir=3D"ltr" >Hey guys - our system test team opened a defect on t=
his, since Ubuntu (as it stands) is broken now with CAPI Flash cards.
<div>&nbsp;</div>
<div><div>Dion opened bug <font face=3D"Default Sans Serif,Verdana,Arial,He=
lvetica,sans-serif" size=3D"2" ><a href=3D"https://bugzilla.linux.ibm.com/s=
how=5Fbug.cgi?id=3D140054" >https://bugzilla.linux.ibm.com/show=5Fbug.cgi?i=
d=3D140054</a> . </font></div>
<div>&nbsp;</div>
<div><font face=3D"Default Sans Serif,Verdana,Arial,Helvetica,sans-serif" s=
ize=3D"2" >So - this is important. You need to tested to confirm that this =
is in-fact the root cause of Dion's bug, fix it, verify that a Surelock AFU=
 boots correctly (and cxlflash loads), and then push a patch in 16.04</font=
> in time for the release (in a few weeks).</div>
<div>&nbsp;</div>
<div>~ Mike</div>
<div>&nbsp;
<div><br><b><font face=3D"Arial" color=3D"#888888" size=3D"3" >Michael C. H=
ollinger</font></b><br><tt><b><font face=3D"" color=3D"#8F8F8F" size=3D"3" =
>=E5=92=8C=E5=AE=87=E5=96=86</font></b></tt><br><font face=3D"Arial" size=
=3D"2" >Master Inventor</font><br><font face=3D"Arial" size=3D"2" >Power Op=
en Source Solutions</font><br><font face=3D"Arial" size=3D"2" >IBM Systems<=
br>Austin, TX Development Lab</font>
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" >        <tbody>   =
             <tr valign=3D"top" >                        <td colspan=3D"3" =
valign=3D"middle" width=3D"680" >                        <hr align=3D"left"=
 size=3D"2" width=3D"100%" ></td>                </tr>                <tr v=
align=3D"top" >                        <td width=3D"100" ><img  src=3D"cid:=
145997438113021" height=3D"100" width=3D"100" ></td>                       =
 <td width=3D"355" ><b><font face=3D"Arial" color=3D"#466BB0" size=3D"1" >P=
hone:</font></b><font face=3D"Arial" color=3D"#5F5F5F" size=3D"1" >&nbsp;1-=
512-286-6688</font><font face=3D"Arial" color=3D"#466BB0" size=3D"1" >&nbsp=
;| </font><b><font face=3D"Arial" color=3D"#466BB0" size=3D"1" >Tie-Line:</=
font></b><font face=3D"Arial" color=3D"#5F5F5F" size=3D"1" >&nbsp;363-6688<=
/font><font face=3D"Arial" color=3D"#466BB0" size=3D"1" >&nbsp;| </font><b>=
<font face=3D"Arial" color=3D"#466BB0" size=3D"1" >Mobile:</font></b><font =
face=3D"Arial" color=3D"#5F5F5F" size=3D"1" >&nbsp;1-512-850-6153</font><br=
>                        <b><font face=3D"Arial" color=3D"#466BB0" size=3D"=
1" >E-mail:</font></b><font face=3D"Arial" color=3D"#5F5F5F" size=3D"1" >&n=
bsp;</font><a href=3D"mailto:mchollin@us.ibm.com" target=3D"=5Fblank" ><u><=
font face=3D"Arial" color=3D"#5F5F5F" size=3D"1" >mchollin@us.ibm.com</font=
></u></a><br>                        <b><font face=3D"Arial" color=3D"#466B=
B0" size=3D"1" >Chat:</font></b><img  alt=3D"Sametime: " src=3D"cid:1459974=
38113022" height=3D"16" width=3D"16" ><font face=3D"Arial" color=3D"#5F5F5F=
" size=3D"1" >&nbsp;mchollin@us.ibm.com </font><br>                        =
<b><font face=3D"Arial" color=3D"#466BB0" size=3D"1" >Find me on:</font></b=
><font face=3D"Arial" color=3D"#5F5F5F" size=3D"1" >&nbsp;</font><a href=3D=
"http://www.linkedin.com/in/mikehollinger" target=3D"=5Fblank" ><img  alt=
=3D"LinkedIn: http://www.linkedin.com/in/mikehollinger" src=3D"cid:14599743=
8113023" height=3D"16" border=3D"0" width=3D"16" ></a><font face=3D"Arial" =
color=3D"#5F5F5F" size=3D"1" >&nbsp;</font><a href=3D"http://www.twitter.co=
m/mike=5Fhollinger" target=3D"=5Fblank" ><img  alt=3D"Twitter: http://www.t=
witter.com/mike=5Fhollinger" src=3D"cid:145997438113024" height=3D"16" bord=
er=3D"0" width=3D"16" ></a><font face=3D"Arial" color=3D"#5F5F5F" size=3D"1=
" >&nbsp;</font><a href=3D"https://plus.google.com/100310751329925639140/" =
target=3D"=5Fblank" ><img  alt=3D"GooglePlus: https://plus.google.com/10031=
0751329925639140/" src=3D"cid:145997438113025" height=3D"16" border=3D"0" w=
idth=3D"16" ></a><font face=3D"Arial" color=3D"#5F5F5F" size=3D"1" >&nbsp;<=
/font><b><font face=3D"Arial" color=3D"#466BB0" size=3D"1" >and within IBM =
on:</font></b><font face=3D"Arial" color=3D"#5F5F5F" size=3D"1" >&nbsp;</fo=
nt><a href=3D"http://w3.ibm.com/connections/profiles/html/profileView.do?em=
ail=3Dmchollin@us.ibm.com&amp;lang=3Den" target=3D"=5Fblank" ><img  alt=3D"=
IBM Connections: http://w3.ibm.com/connections/profiles/html/profileView.do=
?email=3Dmchollin@us.ibm.com&amp;lang=3Den" src=3D"cid:145997438113026" hei=
ght=3D"16" border=3D"0" width=3D"16" ></a><font face=3D"Arial" color=3D"#5F=
5F5F" size=3D"1" >&nbsp;</font></td>                        <td width=3D"22=
5" >                        <div align=3D"right" ><img  alt=3D"IBM" src=3D"=
cid:145997438113027" height=3D"30" width=3D"83" ><br>                      =
  <br>                        <font face=3D"Arial" color=3D"#5F5F5F" size=
=3D"1" >11400 Burnet Road</font><br>                        <font face=3D"A=
rial" color=3D"#5F5F5F" size=3D"1" >Austin, TX 78758</font></div>          =
              </td>                </tr>        </tbody></table>
<div>&nbsp;</div>
<div>&nbsp;</div>
<blockquote data-history-content-modified=3D"1" style=3D"border-left:solid =
#aaaaaa 2px; margin-left:5px; padding-left:5px; direction:ltr; margin-right=
:0px" >----- Original message -----<br>From: "Guilherme G. Piccoli" &lt;gpi=
ccoli@linux.vnet.ibm.com&gt;<br>To: Ian Munsie &lt;imunsie@au1.ibm.com&gt;<=
br>Cc: mikey &lt;mikey@neuling.org&gt;, Michael C Hollinger/Austin/IBM@IBMU=
S, Frederic Barrat &lt;frederic.barrat@fr.ibm.com&gt;, linux-pci &lt;linux-=
pci@vger.kernel.org&gt;, "Matthew R. Ochs" &lt;mrochs@linux.vnet.ibm.com&gt=
;, gwshan &lt;gwshan@linux.vnet.ibm.com&gt;, Manoj Kumar/Austin/IBM@IBMUS, =
paulus &lt;paulus@samba.org&gt;, "andrew.donnellan" &lt;andrew.donnellan@au=
1.ibm.com&gt;, bhelgaas &lt;bhelgaas@google.com&gt;, linuxppc-dev &lt;linux=
ppc-dev@lists.ozlabs.org&gt;, Michael Ellerman &lt;mpe@ellerman.id.au&gt;<b=
r>Subject: Re: [PATCH v4] powerpc/pci: Assign fixed PHB number based on dev=
ice-tree properties<br>Date: Wed, Apr 6, 2016 4:51 PM<br>&nbsp;
<div><font face=3D"Default Monospace,Courier New,Courier,monospace" size=3D=
"2" >On 04/06/2016 04:38 PM, Ian Munsie wrote:<br>&gt;&gt; + &nbsp; &nbsp;/=
* try fixed PHB numbering first, by checking archs and reading<br>&gt;&gt; =
+ &nbsp; &nbsp; * the respective device-tree property. */<br>&gt;&gt; + &nb=
sp; &nbsp;if (machine=5Fis(pseries)) {<br>&gt;&gt; + &nbsp; &nbsp; &nbsp; &=
nbsp;regs =3D of=5Fget=5Fproperty(dn, "reg", NULL);<br>&gt;&gt; + &nbsp; &n=
bsp; &nbsp; &nbsp;if (regs)<br>&gt;&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;return (int)(be32=5Fto=5Fcpu(regs[1]) &amp; 0xFFFF);<br>&gt;&gt; + =
&nbsp; &nbsp;} else if (machine=5Fis(powernv)) {<br>&gt;&gt; + &nbsp; &nbsp=
; &nbsp; &nbsp;prop64 =3D of=5Fget=5Fproperty(dn, "ibm,opal-phbid", NULL);<=
br>&gt;&gt; + &nbsp; &nbsp; &nbsp; &nbsp;if (prop64)<br>&gt;&gt; + &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return (int)(be64=5Fto=5Fcpup(prop64) &amp=
; 0xFFFF);<br>&gt;&gt; + &nbsp; &nbsp;}<br>&gt;<br>&gt; I think these cases=
 should still set the bit in phb=5Fbitmap, otherwise a<br>&gt; virtual PHB =
(e.g. as used in cxl/cxlflash) will be assigned PHB 0, and<br>&gt; since th=
at is already taken it will fail - we're already seeing a<br>&gt; failure i=
n Ubuntu Xenial since Canonical picked this patch up already<br>&gt; (thoug=
h have not confirmed that this is definitely the cause yet).<br>&gt;<br>&gt=
; There might also be some interesting races to think about here if a<br>&g=
t; virtual PHB grabs a PHB number before the real one gets a chance.<br><br=
>This is a very interesting case I didn't think before. Thanks for<br>point=
ing this Ian.<br><br>We can, as you suggested, set the bitmap in any case t=
o avoid conflicts<br>with virtual PHBs.<br><br>And in the case a virtual PH=
B grabs the bitmap before, we just need to<br>add Michael's suggested check=
 and fallback to bitmap PHB numbering in<br>this case.<br><br>Do you think =
this is enough to avoid issues with cxl'a virtual PHBs?<br><br>Thanks,<br><=
br><br>Guilherme</font></div></blockquote></div></div></div></div></div></d=
iv>
<BR>
--=_related 0078CF1D00257F8D_=
Content-Type: image/jpeg; name="Image.145997438113021.jpg"
Content-Disposition: inline; filename="Image.145997438113021.jpg"
Content-ID: <145997438113021>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQAAAQABAAD/4gxYSUNDX1BST0ZJTEUAAQEAAAxITGlubwIQAABtbnRyUkdC
IFhZWiAHzgACAAkABgAxAABhY3NwTVNGVAAAAABJRUMgc1JHQgAAAAAAAAAAAAAAAAAA9tYAAQAA
AADTLUhQICAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABFj
cHJ0AAABUAAAADNkZXNjAAABhAAAAGx3dHB0AAAB8AAAABRia3B0AAACBAAAABRyWFlaAAACGAAA
ABRnWFlaAAACLAAAABRiWFlaAAACQAAAABRkbW5kAAACVAAAAHBkbWRkAAACxAAAAIh2dWVkAAAD
TAAAAIZ2aWV3AAAD1AAAACRsdW1pAAAD+AAAABRtZWFzAAAEDAAAACR0ZWNoAAAEMAAAAAxyVFJD
AAAEPAAACAxnVFJDAAAEPAAACAxiVFJDAAAEPAAACAx0ZXh0AAAAAENvcHlyaWdodCAoYykgMTk5
OCBIZXdsZXR0LVBhY2thcmQgQ29tcGFueQAAZGVzYwAAAAAAAAASc1JHQiBJRUM2MTk2Ni0yLjEA
AAAAAAAAAAAAABJzUkdCIElFQzYxOTY2LTIuMQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAWFlaIAAAAAAAAPNRAAEAAAABFsxYWVogAAAAAAAAAAAAAAAA
AAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAA
AA+EAAC2z2Rlc2MAAAAAAAAAFklFQyBodHRwOi8vd3d3LmllYy5jaAAAAAAAAAAAAAAAFklFQyBo
dHRwOi8vd3d3LmllYy5jaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAABkZXNjAAAAAAAAAC5JRUMgNjE5NjYtMi4xIERlZmF1bHQgUkdCIGNvbG91ciBzcGFjZSAt
IHNSR0IAAAAAAAAAAAAAAC5JRUMgNjE5NjYtMi4xIERlZmF1bHQgUkdCIGNvbG91ciBzcGFjZSAt
IHNSR0IAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZGVzYwAAAAAAAAAsUmVmZXJlbmNlIFZpZXdpbmcg
Q29uZGl0aW9uIGluIElFQzYxOTY2LTIuMQAAAAAAAAAAAAAALFJlZmVyZW5jZSBWaWV3aW5nIENv
bmRpdGlvbiBpbiBJRUM2MTk2Ni0yLjEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHZpZXcAAAAA
ABOk/gAUXy4AEM8UAAPtzAAEEwsAA1yeAAAAAVhZWiAAAAAAAEwJVgBQAAAAVx/nbWVhcwAAAAAA
AAABAAAAAAAAAAAAAAAAAAAAAAAAAo8AAAACc2lnIAAAAABDUlQgY3VydgAAAAAAAAQAAAAABQAK
AA8AFAAZAB4AIwAoAC0AMgA3ADsAQABFAEoATwBUAFkAXgBjAGgAbQByAHcAfACBAIYAiwCQAJUA
mgCfAKQAqQCuALIAtwC8AMEAxgDLANAA1QDbAOAA5QDrAPAA9gD7AQEBBwENARMBGQEfASUBKwEy
ATgBPgFFAUwBUgFZAWABZwFuAXUBfAGDAYsBkgGaAaEBqQGxAbkBwQHJAdEB2QHhAekB8gH6AgMC
DAIUAh0CJgIvAjgCQQJLAlQCXQJnAnECegKEAo4CmAKiAqwCtgLBAssC1QLgAusC9QMAAwsDFgMh
Ay0DOANDA08DWgNmA3IDfgOKA5YDogOuA7oDxwPTA+AD7AP5BAYEEwQgBC0EOwRIBFUEYwRxBH4E
jASaBKgEtgTEBNME4QTwBP4FDQUcBSsFOgVJBVgFZwV3BYYFlgWmBbUFxQXVBeUF9gYGBhYGJwY3
BkgGWQZqBnsGjAadBq8GwAbRBuMG9QcHBxkHKwc9B08HYQd0B4YHmQesB78H0gflB/gICwgfCDII
RghaCG4IggiWCKoIvgjSCOcI+wkQCSUJOglPCWQJeQmPCaQJugnPCeUJ+woRCicKPQpUCmoKgQqY
Cq4KxQrcCvMLCwsiCzkLUQtpC4ALmAuwC8gL4Qv5DBIMKgxDDFwMdQyODKcMwAzZDPMNDQ0mDUAN
Wg10DY4NqQ3DDd4N+A4TDi4OSQ5kDn8Omw62DtIO7g8JDyUPQQ9eD3oPlg+zD88P7BAJECYQQxBh
EH4QmxC5ENcQ9RETETERTxFtEYwRqhHJEegSBxImEkUSZBKEEqMSwxLjEwMTIxNDE2MTgxOkE8UT
5RQGFCcUSRRqFIsUrRTOFPAVEhU0FVYVeBWbFb0V4BYDFiYWSRZsFo8WshbWFvoXHRdBF2UXiReu
F9IX9xgbGEAYZRiKGK8Y1Rj6GSAZRRlrGZEZtxndGgQaKhpRGncanhrFGuwbFBs7G2MbihuyG9oc
AhwqHFIcexyjHMwc9R0eHUcdcB2ZHcMd7B4WHkAeah6UHr4e6R8THz4faR+UH78f6iAVIEEgbCCY
IMQg8CEcIUghdSGhIc4h+yInIlUigiKvIt0jCiM4I2YjlCPCI/AkHyRNJHwkqyTaJQklOCVoJZcl
xyX3JicmVyaHJrcm6CcYJ0kneierJ9woDSg/KHEooijUKQYpOClrKZ0p0CoCKjUqaCqbKs8rAis2
K2krnSvRLAUsOSxuLKIs1y0MLUEtdi2rLeEuFi5MLoIuty7uLyQvWi+RL8cv/jA1MGwwpDDbMRIx
SjGCMbox8jIqMmMymzLUMw0zRjN/M7gz8TQrNGU0njTYNRM1TTWHNcI1/TY3NnI2rjbpNyQ3YDec
N9c4FDhQOIw4yDkFOUI5fzm8Ofk6Njp0OrI67zstO2s7qjvoPCc8ZTykPOM9Ij1hPaE94D4gPmA+
oD7gPyE/YT+iP+JAI0BkQKZA50EpQWpBrEHuQjBCckK1QvdDOkN9Q8BEA0RHRIpEzkUSRVVFmkXe
RiJGZ0arRvBHNUd7R8BIBUhLSJFI10kdSWNJqUnwSjdKfUrESwxLU0uaS+JMKkxyTLpNAk1KTZNN
3E4lTm5Ot08AT0lPk0/dUCdQcVC7UQZRUFGbUeZSMVJ8UsdTE1NfU6pT9lRCVI9U21UoVXVVwlYP
VlxWqVb3V0RXklfgWC9YfVjLWRpZaVm4WgdaVlqmWvVbRVuVW+VcNVyGXNZdJ114XcleGl5sXr1f
D19hX7NgBWBXYKpg/GFPYaJh9WJJYpxi8GNDY5dj62RAZJRk6WU9ZZJl52Y9ZpJm6Gc9Z5Nn6Wg/
aJZo7GlDaZpp8WpIap9q92tPa6dr/2xXbK9tCG1gbbluEm5rbsRvHm94b9FwK3CGcOBxOnGVcfBy
S3KmcwFzXXO4dBR0cHTMdSh1hXXhdj52m3b4d1Z3s3gReG54zHkqeYl553pGeqV7BHtje8J8IXyB
fOF9QX2hfgF+Yn7CfyN/hH/lgEeAqIEKgWuBzYIwgpKC9INXg7qEHYSAhOOFR4Wrhg6GcobXhzuH
n4gEiGmIzokziZmJ/opkisqLMIuWi/yMY4zKjTGNmI3/jmaOzo82j56QBpBukNaRP5GokhGSepLj
k02TtpQglIqU9JVflcmWNJaflwqXdZfgmEyYuJkkmZCZ/JpomtWbQpuvnByciZz3nWSd0p5Anq6f
HZ+Ln/qgaaDYoUehtqImopajBqN2o+akVqTHpTilqaYapoum/adup+CoUqjEqTepqaocqo+rAqt1
q+msXKzQrUStuK4trqGvFq+LsACwdbDqsWCx1rJLssKzOLOutCW0nLUTtYq2AbZ5tvC3aLfguFm4
0blKucK6O7q1uy67p7whvJu9Fb2Pvgq+hL7/v3q/9cBwwOzBZ8Hjwl/C28NYw9TEUcTOxUvFyMZG
xsPHQce/yD3IvMk6ybnKOMq3yzbLtsw1zLXNNc21zjbOts83z7jQOdC60TzRvtI/0sHTRNPG1EnU
y9VO1dHWVdbY11zX4Nhk2OjZbNnx2nba+9uA3AXcit0Q3ZbeHN6i3ynfr+A24L3hROHM4lPi2+Nj
4+vkc+T85YTmDeaW5x/nqegy6LzpRunQ6lvq5etw6/vshu0R7ZzuKO6070DvzPBY8OXxcvH/8ozz
GfOn9DT0wvVQ9d72bfb794r4Gfio+Tj5x/pX+uf7d/wH/Jj9Kf26/kv+3P9t////2wBDAAICAgIC
AQICAgICAgIDAwYEAwMDAwcFBQQGCAcICAgHCAgJCg0LCQkMCggICw8LDA0ODg4OCQsQEQ8OEQ0O
Dg7/2wBDAQICAgMDAwYEBAYOCQgJDg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4ODg4O
Dg4ODg4ODg4ODg4ODg7/wAARCABkAGQDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAEC
AwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0Kx
wRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1
dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ
2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QA
tREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYk
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
RRRQAUUUUAFFFFAH/9k=


--=_related 0078CF1D00257F8D_=
Content-Type: image/jpeg; name="Image.145997438113022.jpg"
Content-Disposition: inline; filename="Image.145997438113022.jpg"
Content-ID: <145997438113022>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEASABIAAD/4gxYSUNDX1BST0ZJTEUAAQEAAAxITGlubwIQAABtbnRyUkdC
IFhZWiAHzgACAAkABgAxAABhY3NwTVNGVAAAAABJRUMgc1JHQgAAAAAAAAAAAAAAAQAA9tYAAQAA
AADTLUhQICAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABFj
cHJ0AAABUAAAADNkZXNjAAABhAAAAGx3dHB0AAAB8AAAABRia3B0AAACBAAAABRyWFlaAAACGAAA
ABRnWFlaAAACLAAAABRiWFlaAAACQAAAABRkbW5kAAACVAAAAHBkbWRkAAACxAAAAIh2dWVkAAAD
TAAAAIZ2aWV3AAAD1AAAACRsdW1pAAAD+AAAABRtZWFzAAAEDAAAACR0ZWNoAAAEMAAAAAxyVFJD
AAAEPAAACAxnVFJDAAAEPAAACAxiVFJDAAAEPAAACAx0ZXh0AAAAAENvcHlyaWdodCAoYykgMTk5
OCBIZXdsZXR0LVBhY2thcmQgQ29tcGFueQAAZGVzYwAAAAAAAAASc1JHQiBJRUM2MTk2Ni0yLjEA
AAAAAAAAAAAAABJzUkdCIElFQzYxOTY2LTIuMQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAWFlaIAAAAAAAAPNRAAEAAAABFsxYWVogAAAAAAAAAAAAAAAA
AAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAA
AA+EAAC2z2Rlc2MAAAAAAAAAFklFQyBodHRwOi8vd3d3LmllYy5jaAAAAAAAAAAAAAAAFklFQyBo
dHRwOi8vd3d3LmllYy5jaAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAABkZXNjAAAAAAAAAC5JRUMgNjE5NjYtMi4xIERlZmF1bHQgUkdCIGNvbG91ciBzcGFjZSAt
IHNSR0IAAAAAAAAAAAAAAC5JRUMgNjE5NjYtMi4xIERlZmF1bHQgUkdCIGNvbG91ciBzcGFjZSAt
IHNSR0IAAAAAAAAAAAAAAAAAAAAAAAAAAAAAZGVzYwAAAAAAAAAsUmVmZXJlbmNlIFZpZXdpbmcg
Q29uZGl0aW9uIGluIElFQzYxOTY2LTIuMQAAAAAAAAAAAAAALFJlZmVyZW5jZSBWaWV3aW5nIENv
bmRpdGlvbiBpbiBJRUM2MTk2Ni0yLjEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHZpZXcAAAAA
ABOk/gAUXy4AEM8UAAPtzAAEEwsAA1yeAAAAAVhZWiAAAAAAAEwJVgBQAAAAVx/nbWVhcwAAAAAA
AAABAAAAAAAAAAAAAAAAAAAAAAAAAo8AAAACc2lnIAAAAABDUlQgY3VydgAAAAAAAAQAAAAABQAK
AA8AFAAZAB4AIwAoAC0AMgA3ADsAQABFAEoATwBUAFkAXgBjAGgAbQByAHcAfACBAIYAiwCQAJUA
mgCfAKQAqQCuALIAtwC8AMEAxgDLANAA1QDbAOAA5QDrAPAA9gD7AQEBBwENARMBGQEfASUBKwEy
ATgBPgFFAUwBUgFZAWABZwFuAXUBfAGDAYsBkgGaAaEBqQGxAbkBwQHJAdEB2QHhAekB8gH6AgMC
DAIUAh0CJgIvAjgCQQJLAlQCXQJnAnECegKEAo4CmAKiAqwCtgLBAssC1QLgAusC9QMAAwsDFgMh
Ay0DOANDA08DWgNmA3IDfgOKA5YDogOuA7oDxwPTA+AD7AP5BAYEEwQgBC0EOwRIBFUEYwRxBH4E
jASaBKgEtgTEBNME4QTwBP4FDQUcBSsFOgVJBVgFZwV3BYYFlgWmBbUFxQXVBeUF9gYGBhYGJwY3
BkgGWQZqBnsGjAadBq8GwAbRBuMG9QcHBxkHKwc9B08HYQd0B4YHmQesB78H0gflB/gICwgfCDII
RghaCG4IggiWCKoIvgjSCOcI+wkQCSUJOglPCWQJeQmPCaQJugnPCeUJ+woRCicKPQpUCmoKgQqY
Cq4KxQrcCvMLCwsiCzkLUQtpC4ALmAuwC8gL4Qv5DBIMKgxDDFwMdQyODKcMwAzZDPMNDQ0mDUAN
Wg10DY4NqQ3DDd4N+A4TDi4OSQ5kDn8Omw62DtIO7g8JDyUPQQ9eD3oPlg+zD88P7BAJECYQQxBh
EH4QmxC5ENcQ9RETETERTxFtEYwRqhHJEegSBxImEkUSZBKEEqMSwxLjEwMTIxNDE2MTgxOkE8UT
5RQGFCcUSRRqFIsUrRTOFPAVEhU0FVYVeBWbFb0V4BYDFiYWSRZsFo8WshbWFvoXHRdBF2UXiReu
F9IX9xgbGEAYZRiKGK8Y1Rj6GSAZRRlrGZEZtxndGgQaKhpRGncanhrFGuwbFBs7G2MbihuyG9oc
AhwqHFIcexyjHMwc9R0eHUcdcB2ZHcMd7B4WHkAeah6UHr4e6R8THz4faR+UH78f6iAVIEEgbCCY
IMQg8CEcIUghdSGhIc4h+yInIlUigiKvIt0jCiM4I2YjlCPCI/AkHyRNJHwkqyTaJQklOCVoJZcl
xyX3JicmVyaHJrcm6CcYJ0kneierJ9woDSg/KHEooijUKQYpOClrKZ0p0CoCKjUqaCqbKs8rAis2
K2krnSvRLAUsOSxuLKIs1y0MLUEtdi2rLeEuFi5MLoIuty7uLyQvWi+RL8cv/jA1MGwwpDDbMRIx
SjGCMbox8jIqMmMymzLUMw0zRjN/M7gz8TQrNGU0njTYNRM1TTWHNcI1/TY3NnI2rjbpNyQ3YDec
N9c4FDhQOIw4yDkFOUI5fzm8Ofk6Njp0OrI67zstO2s7qjvoPCc8ZTykPOM9Ij1hPaE94D4gPmA+
oD7gPyE/YT+iP+JAI0BkQKZA50EpQWpBrEHuQjBCckK1QvdDOkN9Q8BEA0RHRIpEzkUSRVVFmkXe
RiJGZ0arRvBHNUd7R8BIBUhLSJFI10kdSWNJqUnwSjdKfUrESwxLU0uaS+JMKkxyTLpNAk1KTZNN
3E4lTm5Ot08AT0lPk0/dUCdQcVC7UQZRUFGbUeZSMVJ8UsdTE1NfU6pT9lRCVI9U21UoVXVVwlYP
VlxWqVb3V0RXklfgWC9YfVjLWRpZaVm4WgdaVlqmWvVbRVuVW+VcNVyGXNZdJ114XcleGl5sXr1f
D19hX7NgBWBXYKpg/GFPYaJh9WJJYpxi8GNDY5dj62RAZJRk6WU9ZZJl52Y9ZpJm6Gc9Z5Nn6Wg/
aJZo7GlDaZpp8WpIap9q92tPa6dr/2xXbK9tCG1gbbluEm5rbsRvHm94b9FwK3CGcOBxOnGVcfBy
S3KmcwFzXXO4dBR0cHTMdSh1hXXhdj52m3b4d1Z3s3gReG54zHkqeYl553pGeqV7BHtje8J8IXyB
fOF9QX2hfgF+Yn7CfyN/hH/lgEeAqIEKgWuBzYIwgpKC9INXg7qEHYSAhOOFR4Wrhg6GcobXhzuH
n4gEiGmIzokziZmJ/opkisqLMIuWi/yMY4zKjTGNmI3/jmaOzo82j56QBpBukNaRP5GokhGSepLj
k02TtpQglIqU9JVflcmWNJaflwqXdZfgmEyYuJkkmZCZ/JpomtWbQpuvnByciZz3nWSd0p5Anq6f
HZ+Ln/qgaaDYoUehtqImopajBqN2o+akVqTHpTilqaYapoum/adup+CoUqjEqTepqaocqo+rAqt1
q+msXKzQrUStuK4trqGvFq+LsACwdbDqsWCx1rJLssKzOLOutCW0nLUTtYq2AbZ5tvC3aLfguFm4
0blKucK6O7q1uy67p7whvJu9Fb2Pvgq+hL7/v3q/9cBwwOzBZ8Hjwl/C28NYw9TEUcTOxUvFyMZG
xsPHQce/yD3IvMk6ybnKOMq3yzbLtsw1zLXNNc21zjbOts83z7jQOdC60TzRvtI/0sHTRNPG1EnU
y9VO1dHWVdbY11zX4Nhk2OjZbNnx2nba+9uA3AXcit0Q3ZbeHN6i3ynfr+A24L3hROHM4lPi2+Nj
4+vkc+T85YTmDeaW5x/nqegy6LzpRunQ6lvq5etw6/vshu0R7ZzuKO6070DvzPBY8OXxcvH/8ozz
GfOn9DT0wvVQ9d72bfb794r4Gfio+Tj5x/pX+uf7d/wH/Jj9Kf26/kv+3P9t////2wBDAAEBAQEB
AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB
AQH/2wBDAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB
AQEBAQEBAQEBAQEBAQH/wAARCAAQABADASIAAhEBAxEB/8QAFwAAAwEAAAAAAAAAAAAAAAAABQYH
Cv/EACAQAAIDAQEAAgMBAAAAAAAAAAMEAgUGAQgSEwcRFBX/xAAVAQEBAAAAAAAAAAAAAAAAAAAI
Cf/EAB4RAAMAAgMAAwAAAAAAAAAAAAIDBAEFBgcRCBMV/9oADAMBAAIRAxEAPwDRl6U9MaHRbW2p
xFkauTPPtZQMuPgpkaXpSgRcZrkGkZWtpazWO0ZywIZRYUQqqrcLA8htHln0Ve1+or6vpzDq5PoJ
aTNReddqP8u1IVda9plbBlw1K8i0HkDgEwNJ/hOfr4c+7gKb6F8Y4Xa3EXdIPUUJkpnHQ7fHGCI8
qlhkrcKO5Gym4qeKpTHIAcoLNjJ05lmOqTLAgTyr5Hd/H9roawTgNNmbXT197Pau07lVfdqa4fwD
nXilcbRfmHv3fyEregIs28+22KI5rLrSti498iFdwxPciw9+3k+GV70HuJa417DDmDSg0raPH3S4
OUcre7Tfl5GZXgEmLD7r5F0DT0dRDKII3s2omBeroiMCouNi0vpl2S2Nka9aTOkZ3Ln2Q1+H9eXL
ZaX/2Q==


--=_related 0078CF1D00257F8D_=
Content-Type: image/jpeg; name="Image.145997438113023.jpg"
Content-Disposition: inline; filename="Image.145997438113023.jpg"
Content-ID: <145997438113023>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAgAAZABkAAD/7AARRHVja3kAAQAEAAAAPAAA/+4ADkFkb2JlAGTAAAAAAf/b
AIQABgQEBAUEBgUFBgkGBQYJCwgGBggLDAoKCwoKDBAMDAwMDAwQDA4PEA8ODBMTFBQTExwbGxsc
Hx8fHx8fHx8fHwEHBwcNDA0YEBAYGhURFRofHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8fHx8f
Hx8fHx8fHx8fHx8fHx8fHx8f/8AAEQgAEAAQAwERAAIRAQMRAf/EAGoAAAMAAAAAAAAAAAAAAAAA
AAMFBgEAAwEBAAAAAAAAAAAAAAAAAgMEBQYQAAIBBAICAwEAAAAAAAAAAAECAxEEBQYAEiITITEH
FBEAAgICAQUBAAAAAAAAAAAAAQIRAwAEEiFRYSIUBf/aAAwDAQACEQMRAD8Avdc1jEZDUrG8TFLd
5Gcxo0zRwsrs0Qd+zP5ly1TzestK2EEwucrRriyvkAS0+MS7rrSYjXry/mwqWPWKT+e6WFEZJlUl
CGUdlPYfB5TRcrtAacf8pUSVjB6V+va3reuWWMyq3S3dpe+6ZVjU0jWL108mU17D6pwtr817G5qV
gp3wdDaWteBBkPOSeY/VMTk9O2jAwrdTZLN5U3OOHQMpid1oGIYkOQKUAPGnUK2I8rCpBypLfVgZ
6tOf/9k=


--=_related 0078CF1D00257F8D_=
Content-Type: image/jpeg; name="Image.145997438113024.jpg"
Content-Disposition: inline; filename="Image.145997438113024.jpg"
Content-ID: <145997438113024>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEASABIAAD/2wBDAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB
AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/2wBDAQEBAQEBAQEBAQEBAQEBAQEBAQEB
AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/wAARCAAQABADASIA
AhEBAxEB/8QAFgABAQEAAAAAAAAAAAAAAAAACAcK/8QAHRAAAgIDAQEBAAAAAAAAAAAABAUDBgEC
CAcJEv/EABQBAQAAAAAAAAAAAAAAAAAAAAj/xAAdEQADAAIDAQEAAAAAAAAAAAADBAUBAgYHFAgV
/9oADAMBAAIRAxEAPwDWt7j9F6XzL0I58f8AZ6hYRqgVV69aKf6FU1bJrmPDIQqJkrsyIyEIkyGJ
qtI0AsVHlsoudjYk7VYtNUNjcGjgXvzqPqv3ZlRLQg8gFoq5M1uthOU1+3LXCJAHJqpARJDJbS1A
ZNj37yvZ1IcDj/lOssJEcRBEg8Yaf7f4muXXptaGguvmNVQ1yPfKxiw88uTL0RSQTvBsziGsgHqa
2qtEzLEOu2ytnQcFA7xY2Eb4lnkn0rPHvGvn/H9NZJa2eXabhadwCLteWQ2gBDuVZoRqvBXKYiC4
UiNfsYbKIBgw8vecwiU9mdnA2BkPpS6On9StGHKJQ7RszEpPgPtQYSiuJkKM/I1WdwKgV3dW3wwd
T0OZ2oBAAK2iGTslHJYv1LY+hJ6xrwo/RHGrdTkH66mshOlyabRAAynC6CI2nm39Jjwtk1aPknY0
kMttsu71sKJA/9k=


--=_related 0078CF1D00257F8D_=
Content-Type: image/jpeg; name="Image.145997438113025.jpg"
Content-Disposition: inline; filename="Image.145997438113025.jpg"
Content-ID: <145997438113025>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEASABIAAD/2wBDAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB
AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/2wBDAQEBAQEBAQEBAQEBAQEBAQEBAQEB
AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/wAARCAAQABADASIA
AhEBAxEB/8QAFwAAAwEAAAAAAAAAAAAAAAAAAgMEBv/EAB4QAAICAwEBAQEAAAAAAAAAAAUHBAYC
AwgJARYU/8QAFQEBAQAAAAAAAAAAAAAAAAAAAgT/xAAdEQADAQACAwEAAAAAAAAAAAACAwQFAQYR
EhMU/9oADAMBAAIRAxEAPwAXv2R6CX30xfCBW/WbMrH7Lte48/LcPIZzTqK8pMHW5yiqocT4HoVm
iQgoUZA+B8bAQD1maVJfIck3LiFjsmXsm7Plb0F7/RfobQ+WGa/CDcxIdkrvm1kbbjdXAwgeMWC6
Pqquslf5W69xNGiMajkym6AROVbORn/KBI7w8OZB+R8Xkt/q7xb6d9b3FTczdgEEK1e2TzLaGtQc
xZt8S6kng5rbewUWqXaVQrOGizDK8vhyLG+1a7VImMLH9wqykgh4F9xBywM/WDtb1A5EuLa5k7Bg
INT9uAGcrsG/zFknxKVSWTnqN8PRbZdo1Dq4aXNDLuhA4sj9TdrcTJlwOkTWSRo+dxwOS7Uc/Ycf
DwNcTqyut113Ys4udKyGu3Wm3KXjZGye1xs1ZJ6+P00O4WS/krgEEaiN4L0+0o7pasHdkmjDPReI
Cha4l4KOshOOdPwrL9Bw5kwceYuS9Q+/n9RE8v/Z


--=_related 0078CF1D00257F8D_=
Content-Type: image/jpeg; name="Image.145997438113026.jpg"
Content-Disposition: inline; filename="Image.145997438113026.jpg"
Content-ID: <145997438113026>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAgAAZABkAAD/7AARRHVja3kAAQAEAAAAZAAA/+4ADkFkb2JlAGTAAAAAAf/b
AIQAAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQICAgICAgICAgIC
AwMDAwMDAwMDAwEBAQEBAQECAQECAgIBAgIDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMD
AwMDAwMDAwMDAwMDAwMDAwMD/8AAEQgAEAAQAwERAAIRAQMRAf/EAGMAAQEBAAAAAAAAAAAAAAAA
AAYFCQEBAQEAAAAAAAAAAAAAAAAABQkGEAACAwEBAQEAAAAAAAAAAAAFBgMEBwIBEwgRAAICAgMA
AwEBAAAAAAAAAAIDAQQFBhITBxEUCCEi/9oADAMBAAIRAxEAPwDef9GfoW25Tp7c3K1J6h0Kl21J
ig09DCiEooJOiKOKtKkqMAhjVyrQVVj4ogSJXw9y13btSQQS04KkUdiVX6I/R2yTuLtawtmaVGpA
yRQANKZYIsEABsSr+KICYwhM5I4EIAQmZoH+ffz9jdtxdvIXbPQqrIgUjDOZMk2rkiJTUMgOxLhE
ReECIDMg2WlK2eabMKxo1wZRKJRRsUs862Vhz/nPy+ZKrbkYSPwg4SWFekBE5lITHL/F22FPL0fs
k9+n1B1Lepzd+xp+F+77lhtzpaxtDitUcpViygiV9czVwJnKVQtayWSwYSXqCI5hISTIL/OZ9R8X
NWuWNgUNYqFTKTjTam6m5A25+YAILuZbUfzx7a9mBIVmMkCWRAkv1LPbOWKUeRNV/MVewr30PnNn
Pd6tirhzUt5YYEcpVsiy+Uro4Wa4zsd4uGhUtioSm9nsfHuSiQkk4a9o8H2Ovstq/iEY+3jr9mm+
RvCRVeyixcrk+IMni2usqjQGIZxawYKVPZIjeQ+nYbHZFV/LHmAo/VvIfGKMRvwN9DRMVwTFjMrt
mu4kz5KE0qZId1dcFaVUXnXLLjmeSaLdd8wfO+htgKEipH8qwdOYhxAFpEozTxZosJcy7gvFiFMK
Dgn+4eWbjznmGnBJJ2x5V4znsntSMgbLVXT6bjOvQL4JNPmskl1vF7YcMrY0UrkQJAlCxnrD5kzf
vSMbZw9Q7mOQvcVLkbWR5ENjKSDAZW7ahJV9ckEsJe+JP7U8msmWlED/AP/Z


--=_related 0078CF1D00257F8D_=
Content-Type: image/gif; name="Image.145997438113027.gif"
Content-Disposition: inline; filename="Image.145997438113027.gif"
Content-ID: <145997438113027>
Content-Transfer-Encoding: base64

R0lGODlhUwAeALMAAP///wCKvwCz7wA+abLc7H/E33/Z90yt0kzK9LLo+gAAAAAAAAAAAAAAAAAA
AAAAACH5BAAAAAAALAAAAABTAB4AAAT/cMhJKwAi680zMlcIBGRpkmJ6rkEaVjB1dXRnJCJ7Ei5A
6KaecEgsGo/IpHLJbKZi0FltugGNgCWe6IdF9aAxKXV86ZIKqYK55Wy73/C4XBkedlyGuwqIvqiB
dDBEeiJ5GwguXSGKc42Oj5CRInVCYzY9XQcAB4xIlD2WVUIrfyWlZyuSqqusrV+CdqEZVok7Vyw+
qUmfLrIatDm2gFxBrsbHyG+8KYQhhhqIeyZapwF9xCWBFrEbeM1ltuDZF9heyefo6RdgsL414ixa
AKV9uYCv7BNi7r/wK/K3tmARUeAAQHWOCBRQWA9howMFCRzIJwMDPwE3gukAqKZhuRMhFQosFElR
n0VfH2ptVJHiYzE/EAFEAAA7


--=_related 0078CF1D00257F8D_=--
