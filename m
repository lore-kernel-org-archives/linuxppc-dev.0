Return-Path: <intermediadc@hotmail.com>
Received: from DUB004-OMC4S29.hotmail.com (dub004-omc4s29.hotmail.com
 [157.55.2.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 33E221A0D86
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 19:13:39 +1100 (AEDT)
Message-ID: <DUB117-W3923369524FE8978353029C8480@phx.gbl>
Content-Type: multipart/alternative;
 boundary="_8f55bb83-a857-472b-960a-4fd738632a4e_"
From: luigi burdo <intermediadc@hotmail.com>
To: =?iso-8859-1?B?TWljaGVsIETkbnplcg==?= <michel@daenzer.net>
Subject: RE: PowerMac G5 Quad Issue reporting
Date: Wed, 21 Jan 2015 09:13:33 +0100
In-Reply-To: <54BF49B6.9020704@daenzer.net>
References: <20150120054506.F13591402E0@ozlabs.org>, ,
 <54BE3B79.9070004@linux.vnet.ibm.com>,
 <DUB117-W1231755B8D223132D571329C84B0@phx.gbl>, <54BF49B6.9020704@daenzer.net>
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_8f55bb83-a857-472b-960a-4fd738632a4e_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Mike=2C thank you for your reply .
yes im sorry i was fixed the issue yesterday night=2C
forcing the module  i2c_powermac loaded from etc/modules
stange it was not loaded by default like it was before.
in any way *fixed :-)

About the RadeonHD =2C yes you are true=2C have the Mesa/Gallium=20
working is problematic but what is not problematic in the good ppc world ? =
:-)

Right now im using the software resterized i didnt had the time
to check everythings regarding the gpu because i was need=20
first fix the turbine noise in my home made by powermac (or my wife had bee=
n kill me)
The good thing i see all the firmware -nonfree loaded without errors=20
before not and with lubuntu 14.04ts i dint have a good rasterizing too on 6=
570hd.
Forget to mention=2C before for have the radeonhd working on g5 quad i was =
need the X1900gt in couple with 4xxx and 6xxx hd=2C
now im using it in couple with and Nvidia with apple firmware. i think this=
 is the best advance for make people=20
from the ppc apple community swap finnally their gpu.
I hope soon will be able to have the mesa gallium working there for advance=
 the communty .

here couple of screenshots.

http://i1249.photobucket.com/albums/hh511/tlosm/BenchmarkG5/1_zps025bc7ed.j=
pg

http://i1249.photobucket.com/albums/hh511/tlosm/BenchmarkG5/2_zps84cf4cac.j=
pg

http://i1249.photobucket.com/albums/hh511/tlosm/BenchmarkG5/3_zpsfded5971.j=
pg


Need to Notice to  Alexander Graf the Kvm and Kvm-pr are running great too.

Thank you very mutch to all the LinuxPPC Devs=20

Luigi Burdo


> Date: Wed=2C 21 Jan 2015 15:39:50 +0900
> From: michel@daenzer.net
> To: intermediadc@hotmail.com
> Subject: Re: PowerMac G5 Quad Issue reporting
> CC: linuxppc-dev@lists.ozlabs.org=3B linux-kernel@vger.kernel.org
>=20
> On 20.01.2015 20:52=2C luigi burdo wrote:
> > Hello all LinuxPPc Developer=2C
> > need to report a issue that im facing from kernel 3.16 and up.
> >=20
> > The fans of powermac g5 quad start boosting like a turbo jet after the
> > system is
> > been loaded and up.
> > Usually this become after about 30-60 seconds when the system is loaded=
.
>=20
> You need to load the i2c_powermac kernel module.
>=20
>=20
> > Need to report to Michel D. from amd.com . The RadeonHD 6570 now is
> > working on PowerMac G5 too
> > look like the Xorg bigendian  issue related Evergreen / Northern  is
> > been fixed =3B-)
>=20
> Xorg itself has always been working=2C only OpenGL can be problematic.
> Have you verified r600_dri.so is used for that?
>=20
>=20
> --=20
> Earthling Michel D=E4nzer               |               http://www.amd.co=
m
> Libre software enthusiast             |             Mesa and X developer
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
 		 	   		  =

--_8f55bb83-a857-472b-960a-4fd738632a4e_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 12pt=3B
font-family:Calibri
}
--></style></head>
<body class=3D'hmmessage'><div dir=3D'ltr'>Hi Mike=2C thank you for your re=
ply .<br>yes im sorry i was fixed the issue yesterday night=2C<br>forcing t=
he module  i2c_powermac loaded from etc/modules<br>stange it was not loaded=
 by default like it was before.<br>in any way *fixed :-)<br><br>About the R=
adeonHD =2C yes you are true=2C have the Mesa/Gallium <br>working is proble=
matic but what is not problematic in the good ppc world ? :-)<br><br>Right =
now im using the software resterized i didnt had the time<br>to check every=
things regarding the gpu because i was need <br>first fix the turbine noise=
 in my home made by powermac (or my wife had been kill me)<br>The good thin=
g i see all the firmware -nonfree loaded without errors <br>before not and =
with lubuntu 14.04ts i dint have a good rasterizing too on 6570hd.<br>Forge=
t to mention=2C before for have the radeonhd working on g5 quad i was need =
the X1900gt in couple with 4xxx and 6xxx hd=2C<br>now im using it in couple=
 with and Nvidia with apple firmware. i think this is the best advance for =
make people <br>from the ppc apple community swap finnally their gpu.<br>I =
hope soon will be able to have the mesa gallium working there for advance t=
he communty .<br><br>here couple of screenshots.<br><br><a href=3D"http://i=
1249.photobucket.com/albums/hh511/tlosm/BenchmarkG5/1_zps025bc7ed.jpg" targ=
et=3D"_blank">http://i1249.photobucket.com/albums/hh511/tlosm/BenchmarkG5/1=
_zps025bc7ed.jpg</a><br><br><a href=3D"http://i1249.photobucket.com/albums/=
hh511/tlosm/BenchmarkG5/2_zps84cf4cac.jpg" target=3D"_blank">http://i1249.p=
hotobucket.com/albums/hh511/tlosm/BenchmarkG5/2_zps84cf4cac.jpg</a><br><br>=
<a href=3D"http://i1249.photobucket.com/albums/hh511/tlosm/BenchmarkG5/3_zp=
sfded5971.jpg" target=3D"_blank">http://i1249.photobucket.com/albums/hh511/=
tlosm/BenchmarkG5/3_zpsfded5971.jpg</a><br><br><br>Need to Notice to <span =
class=3D"st"> <em>Alexander Graf</em> the Kvm and Kvm-pr are running great =
too.</span><br><br>Thank you very mutch to all the LinuxPPC Devs <br><br>Lu=
igi Burdo<br><br><br><div>&gt=3B Date: Wed=2C 21 Jan 2015 15:39:50 +0900<br=
>&gt=3B From: michel@daenzer.net<br>&gt=3B To: intermediadc@hotmail.com<br>=
&gt=3B Subject: Re: PowerMac G5 Quad Issue reporting<br>&gt=3B CC: linuxppc=
-dev@lists.ozlabs.org=3B linux-kernel@vger.kernel.org<br>&gt=3B <br>&gt=3B =
On 20.01.2015 20:52=2C luigi burdo wrote:<br>&gt=3B &gt=3B Hello all LinuxP=
Pc Developer=2C<br>&gt=3B &gt=3B need to report a issue that im facing from=
 kernel 3.16 and up.<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B The fans of powerma=
c g5 quad start boosting like a turbo jet after the<br>&gt=3B &gt=3B system=
 is<br>&gt=3B &gt=3B been loaded and up.<br>&gt=3B &gt=3B Usually this beco=
me after about 30-60 seconds when the system is loaded.<br>&gt=3B <br>&gt=
=3B You need to load the i2c_powermac kernel module.<br>&gt=3B <br>&gt=3B <=
br>&gt=3B &gt=3B Need to report to Michel D. from amd.com . The RadeonHD 65=
70 now is<br>&gt=3B &gt=3B working on PowerMac G5 too<br>&gt=3B &gt=3B look=
 like the Xorg bigendian  issue related Evergreen / Northern  is<br>&gt=3B =
&gt=3B been fixed =3B-)<br>&gt=3B <br>&gt=3B Xorg itself has always been wo=
rking=2C only OpenGL can be problematic.<br>&gt=3B Have you verified r600_d=
ri.so is used for that?<br>&gt=3B <br>&gt=3B <br>&gt=3B -- <br>&gt=3B Earth=
ling Michel D=E4nzer               |               http://www.amd.com<br>&g=
t=3B Libre software enthusiast             |             Mesa and X develop=
er<br>&gt=3B _______________________________________________<br>&gt=3B Linu=
xppc-dev mailing list<br>&gt=3B Linuxppc-dev@lists.ozlabs.org<br>&gt=3B htt=
ps://lists.ozlabs.org/listinfo/linuxppc-dev<br></div> 		 	   		  </div></bo=
dy>
</html>=

--_8f55bb83-a857-472b-960a-4fd738632a4e_--
