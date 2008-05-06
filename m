Return-Path: <ron_madrid@hotmail.com>
Received: from bay0-omc1-s36.bay0.hotmail.com (bay0-omc1-s36.bay0.hotmail.com
	[65.54.246.108]) by ozlabs.org (Postfix) with ESMTP id 60AE1DDEDF
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 07:10:37 +1000 (EST)
Message-ID: <BAY114-W949ADEBC809E7A60716CCF4D60@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_20cc832d-76ed-49b8-bd53-d337c0ac5d43_"
From: Ronald Madrid <ron_madrid@hotmail.com>
To: <linuxppc-dev@ozlabs.org>
Subject: ifconfig MPC8313
Date: Tue, 6 May 2008 14:10:36 -0700
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_20cc832d-76ed-49b8-bd53-d337c0ac5d43_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello all,

I am working on porting linux 2.6.25 with a custom MPC8313 based board, but=
 am having a little bit of trouble with the ethernet, more specifically ifc=
onfig.

after typing "ifconfig eth0 10.196.31.84" I receive the following error
ifconfig: SIOCSIFFLAGS: Cannot assign requested address

after entering a MAC address via "ifconfig eth0 hw ether"  I receive this e=
rror.
e0024520:01 not found
eth0: Could not attach to PHY
ifconfig: SIOCSIFFLAGS: No such device

which I have traced to bus_find_device, but I'm not sure what to make of th=
is.

I'm not sure where I'm going wrong here, and I'm sure that it's something t=
hat I'm forgetting to do/include.

Sorry if this isn't enough information, but I don't know enough to know wha=
t other information would be needed.


Ron

_________________________________________________________________
Get Free (PRODUCT) RED=99  Emoticons, Winks and Display Pics.
http://joinred.spaces.live.com?ocid=3DTXT_HMTG_prodredemoticons_052008=

--_20cc832d-76ed-49b8-bd53-d337c0ac5d43_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'><div style=3D"text-align: left;">Hello all,<br><b=
r>I am working on porting linux 2.6.25 with a custom MPC8313 based board, b=
ut am having a little bit of trouble with the ethernet, more specifically i=
fconfig.<br><br>after typing "ifconfig eth0 10.196.31.84" I receive the fol=
lowing error<br>ifconfig: SIOCSIFFLAGS: Cannot assign requested address<br>=
<br>after entering a MAC address via "ifconfig eth0 hw ether"&nbsp; I recei=
ve this error.<br>e0024520:01 not found<br>eth0: Could not attach to PHY<br=
>ifconfig: SIOCSIFFLAGS: No such device<br><br>which I have traced to bus_f=
ind_device, but I'm not sure what to make of this.<br><br>I'm not sure wher=
e I'm going wrong here, and I'm sure that it's something that I'm forgettin=
g to do/include.<br><br>Sorry if this isn't enough information, but I don't=
 know enough to know what other information would be needed.<br><br></div><=
br>Ron<br><br /><hr />Get Free (PRODUCT) RED=99  Emoticons, Winks and Displ=
ay Pics. <a href=3D'http://joinred.spaces.live.com?ocid=3DTXT_HMTG_prodrede=
moticons_052008' target=3D'_new'>Check it out!</a></body>
</html>=

--_20cc832d-76ed-49b8-bd53-d337c0ac5d43_--
