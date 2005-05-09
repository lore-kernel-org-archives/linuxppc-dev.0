Return-Path: <graju@facetime.com>
Received: from postman.facetime.com (unknown [203.145.176.100])
	by ozlabs.org (Postfix) with ESMTP id 82362679E1
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 May 2005 20:35:55 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C55483.01853BE9"
Date: Mon, 9 May 2005 16:06:49 +0530
Message-ID: <83986B58C72FC447AAC98F916BAB6A5734EDB0@postman.facetime.com>
From: "Gopala Krishnam Raju" <graju@facetime.com>
To: "Vijesh VH" <vijesh.vh@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Linuxppc-embedded Digest, montavista
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

------_=_NextPart_001_01C55483.01853BE9
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Vijesh
=20
both the target and the host are the same. Then also i am getting the =
same problem
=20
Regards
=20
GGKRAJU

-----Original Message-----
From: Vijesh VH [mailto:vijesh.vh@gmail.com]
Sent: Monday, May 09, 2005 3:50 PM
To: Gopala Krishnam Raju
Subject: Re: Linuxppc-embedded Digest, montavista


raju,

     if you use that you will get that error only. you have create it =
for your specified target. (if your target and host is not same)


On 5/9/05, Gopala Krishnam Raju < graju@facetime.com> wrote:=20

Hello vijesh
=20
that i could not make i am getting error for that so i am using the base =
os initrd i.e fedora core 3 initrd
=20
Regards
=20
GGKRAJU


-----Original Message-----
From: Vijesh VH [mailto: vijesh.vh@gmail.com]
Sent: Monday, May 09, 2005 3:14 PM
To: Gopala Krishnam Raju
Subject: Re: Linuxppc-embedded Digest, montavista


Hello Raju,
You have to create Initrd using initrd command and do necessary changes =
in the grub and in /boot folder

Regards
Vijesh..=20


On 5/9/05, Gopala Krishnam Raju < graju@facetime.com> wrote:=20

hello Linux gurus

I have created a boot image for montavista doing the following way.

1. I did make mrproper.

2. Then make xconfig.

3. Selected the target architecture.

4. saved the configuration file and then=20

5. I have said make dep.  There was no errors it compiled well.

6. I ran make bzImage to get the bzImage.  It also went well without any =
errors.

7. got the bzImage in /linux..../arch/i386/boot/.  then i have copied =
this to /boot.=20

8. Made necessary changes in the grub.conf.

        but while booting i am getting an error saying that vfs: kernal =
panic.
        any ideas regarding this.

        i also tried with make modules.=20

        that also went well. but after starting with the new kernel it =
is giving error vfs: kernal panic.

        target and host are both platforms.

Regards

GGKRAJU
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded





--=20
Thanks and Regards,
Vijesh V H=20




--=20
Thanks and Regards,
Vijesh V H=20


------_=_NextPart_001_01C55483.01853BE9
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">


<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D671573510-09052005><FONT face=3DArial color=3D#0000ff =
size=3D2>Hello=20
Vijesh</FONT></SPAN></DIV>
<DIV><SPAN class=3D671573510-09052005><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D671573510-09052005><FONT face=3DArial color=3D#0000ff =
size=3D2>both=20
the target and the host are the same. Then also i am getting the same=20
problem</FONT></SPAN></DIV>
<DIV><SPAN class=3D671573510-09052005><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D671573510-09052005><FONT face=3DArial color=3D#0000ff =

size=3D2>Regards</FONT></SPAN></DIV>
<DIV><SPAN class=3D671573510-09052005><FONT face=3DArial color=3D#0000ff =

size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D671573510-09052005><FONT face=3DArial color=3D#0000ff =

size=3D2>GGKRAJU</FONT></SPAN></DIV>
<BLOCKQUOTE>
  <DIV class=3DOutlookMessageHeader dir=3Dltr align=3Dleft><FONT =
face=3DTahoma=20
  size=3D2>-----Original Message-----<BR><B>From:</B> Vijesh VH=20
  [mailto:vijesh.vh@gmail.com]<BR><B>Sent:</B> Monday, May 09, 2005 3:50 =

  PM<BR><B>To:</B> Gopala Krishnam Raju<BR><B>Subject:</B> Re: =
Linuxppc-embedded=20
  Digest, =
montavista<BR><BR></FONT></DIV>raju,<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;=20
  if you use that you will get that error only. you have create it for =
your=20
  specified target. (if your target and host is not same)<BR><BR>
  <DIV><SPAN class=3Dgmail_quote>On 5/9/05, <B =
class=3Dgmail_sendername>Gopala=20
  Krishnam Raju</B> &lt;<A=20
  href=3D"mailto:graju@facetime.com">graju@facetime.com</A>&gt; =
wrote:</SPAN>
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: =
rgb(204,204,204) 1px solid">
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>Hello=20
    vijesh</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff =
size=3D2></FONT></SPAN>&nbsp;</DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>that i could =
not make i am=20
    getting error for that so i am using the base os initrd i.e fedora =
core 3=20
    initrd</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff =
size=3D2></FONT></SPAN>&nbsp;</DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff =
size=3D2>Regards</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff =
size=3D2></FONT></SPAN>&nbsp;</DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff =
size=3D2>GGKRAJU</FONT></SPAN></DIV>
    <DIV><SPAN class=3De id=3Dq_103c0f109f2d2fb5_1>
    <BLOCKQUOTE>
      <DIV dir=3Dltr align=3Dleft><FONT face=3DTahoma =
size=3D2>-----Original=20
      Message-----<BR><B>From:</B> Vijesh VH [mailto:<A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"mailto:vijesh.vh@gmail.com"=20
      target=3D_blank>vijesh.vh@gmail.com</A>]<BR><B>Sent:</B> Monday, =
May 09,=20
      2005 3:14 PM<BR><B>To:</B> Gopala Krishnam Raju<BR><B>Subject:</B> =
Re:=20
      Linuxppc-embedded Digest, montavista<BR><BR></FONT></DIV>Hello=20
      Raju,<BR>You have to create Initrd using initrd command and do =
necessary=20
      changes in the grub and in /boot folder<BR><BR>Regards<BR>Vijesh.. =

<BR><BR>
      <DIV><SPAN class=3Dgmail_quote>On 5/9/05, <B =
class=3Dgmail_sendername>Gopala=20
      Krishnam Raju</B> &lt;<A=20
      onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
      href=3D"mailto:graju@facetime.com" =
target=3D_blank>graju@facetime.com</A>&gt;=20
      wrote:</SPAN>=20
      <BLOCKQUOTE class=3Dgmail_quote=20
      style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; =
BORDER-LEFT: rgb(204,204,204) 1px solid">hello=20
        Linux gurus<BR><BR>I have created a boot image for montavista =
doing the=20
        following way.<BR><BR>1. I did make mrproper.<BR><BR>2. Then =
make=20
        xconfig.<BR><BR>3. Selected the target architecture.<BR><BR>4. =
saved the=20
        configuration file and then <BR><BR>5. I have said make=20
        dep.&nbsp;&nbsp;There was no errors it compiled well.<BR><BR>6. =
I ran=20
        make bzImage to get the bzImage.&nbsp;&nbsp;It also went well =
without=20
        any errors.<BR><BR>7. got the bzImage in=20
        /linux..../arch/i386/boot/.&nbsp;&nbsp;then i have copied this =
to /boot.=20
        <BR><BR>8. Made necessary changes in the=20
        =
grub.conf.<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;but=20
        while booting i am getting an error saying that vfs: kernal=20
        panic.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;any =
ideas=20
        regarding =
this.<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i=20
        also tried with make modules.=20
        <BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;that =
also went=20
        well. but after starting with the new kernel it is giving error =
vfs:=20
        kernal=20
        =
panic.<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;target and =

        host are both=20
        =
platforms.<BR><BR>Regards<BR><BR>GGKRAJU<BR>_____________________________=
__________________<BR>Linuxppc-embedded=20
        mailing list<BR><A=20
        onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
        href=3D"mailto:Linuxppc-embedded@ozlabs.org"=20
        target=3D_blank>Linuxppc-embedded@ozlabs.org</A><BR><A=20
        onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
        href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded"=20
        =
target=3D_blank>https://ozlabs.org/mailman/listinfo/linuxppc-embedded</A>=
<BR></BLOCKQUOTE></DIV><BR><BR><BR>--=20
      <BR>Thanks and Regards,<BR>Vijesh V H=20
  </BLOCKQUOTE></SPAN></DIV></BLOCKQUOTE></DIV><BR><BR><BR>-- <BR>Thanks =
and=20
  Regards,<BR>Vijesh V H </BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C55483.01853BE9--
