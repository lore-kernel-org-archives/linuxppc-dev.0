Return-Path: <kkboyanov@gmail.com>
Received: from wx-out-0102.google.com (wx-out-0102.google.com [66.249.82.194])
	by ozlabs.org (Postfix) with ESMTP id A543E67B14
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 May 2006 03:11:46 +1000 (EST)
Received: by wx-out-0102.google.com with SMTP id t5so533818wxc
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 10:11:44 -0700 (PDT)
Message-ID: <929bf310605241005q1987845di@mail.gmail.com>
Date: Wed, 24 May 2006 19:05:32 +0200
From: "Konstantin Boyanov" <kkboyanov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: VME driver problem on MVME6100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_47599_4848032.1148490332826"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_47599_4848032.1148490332826
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi there,

These days I'm trying to "bring up" a VME driver on a Motorola SBC but I'm
getting in some troubles.
Actually there are no problems with the driver itself, methinks, it loads
correctly and everithing seems to be fine.
But when I try to create an outbound window, in order to "talk" some other
boards in the crate I get this:

__ioremap(): phys addr 01000000 is RAM lr d100be34
mode 0
vmedrv: No memory for outbound window
testout: VME_IOCTL_SET_OUTBOUND failed.  Errno =3D 12

I'm not sure I understand all of this anyways... Except that there is no
sufficient memory to map for the outbound window.
That's what this test is supposed to do is to open the appropriate devices
for the VME bus (in this case /dev/vme_m[0-7]), configure the outbound
windows from 0 through 6 (the 7th is reserved) and then verifies that data
can be read through these outbound windows.
I'm using an VME driver downloaded from vmelinux.org and here is the source
of the test program I'm trying to run ->
http://www-zeuthen.desy.de/~boyanov/testOutWindow.txt<http://www-zeuthen.de=
sy.de/%7Eboyanov/testOutWindow.txt>

I'm sorry for the newb question, but any ideas what is going wrong?
Thank you.

Kind regards,
Konstantin Boyanov

------=_Part_47599_4848032.1148490332826
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi there,<br>
<br>
These days I'm trying to &quot;bring up&quot; a VME driver on a Motorola SB=
C but I'm getting in some troubles.<br>
Actually there are no problems with the driver itself, methinks, it loads c=
orrectly and everithing seems to be fine.<br>
But when I try to create an outbound window, in order to &quot;talk&quot; s=
ome other boards in the crate I get this:<br>
<br>
__ioremap(): phys addr 01000000 is RAM lr d100be34<br>
mode 0<br>
vmedrv: No memory for outbound window<br>
testout: VME_IOCTL_SET_OUTBOUND failed.&nbsp; Errno =3D 12<br>
<br>
I'm not sure I understand all of this anyways... Except that there is no su=
fficient memory to map for the outbound window.<br>
That's what this test is supposed to do is to open the appropriate
devices for the VME bus (in this case /dev/vme_m[0-7]), configure the
outbound windows from 0 through 6 (the 7th is reserved) and then
verifies that data can be read through these outbound windows.<br>
I'm using an VME driver downloaded from <a href=3D"http://vmelinux.org" tar=
get=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">vme=
linux.org</a> and here is the
source of the test program I'm trying to run -&gt;
<a href=3D"http://www-zeuthen.desy.de/%7Eboyanov/testOutWindow.txt" target=
=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">http:/=
/www-zeuthen.desy.de/~boyanov/testOutWindow.txt</a><br>
<br>
I'm sorry for the newb question, but any ideas what is going wrong?<br>
Thank you.<br>
<br>
Kind regards,<br>
Konstantin Boyanov<br>




------=_Part_47599_4848032.1148490332826--
