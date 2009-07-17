Return-Path: <gurumurthy.gm@gmail.com>
MIME-Version: 1.0
Date: Fri, 17 Jul 2009 16:01:29 +0530
Message-ID: <adaf92990907170331x1ff6aa44h517785ed1b07df16@mail.gmail.com>
Subject: USB Device not working in MPC8280 PowerPC
From: Gurumurthy Gowdar <gurumurthy.gm@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016364ef3c48e8219046ee44afc
Cc: dev-owner@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016364ef3c48e8219046ee44afc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dear LinuxPPC members,
                                      am facing problem on writing USB
device port driver for MPC8280,when i connect it to the host PC through USB
cable .device descriptor is happening host is setting the address but device
configuration is not happening properly...it hangs there in USB busy
handler.


below is the output of the snippet in hyperterminal for usb debugging

Debug statements

GetDescriptor request length = 0x40
Device Descriptor...
bd status = 3ec0
 In TX USB event register = 108
Recieved PID token = 0x3cc0
USB:SetAddress 2
bd status = 3800
bd status = 3ac0
 In TX USB event register = 108
GetDescriptor request length = 0x12
Device Descriptor...
bd status = 3ec0
 In TX USB event register = 109
Recieved PID token = 0x3cc0
In USB_BUSY HANDLER : 0x108

it hangs in usb busy handler , am feeling data pid toggling may be the
issue.

please help me out to sort this issue....let me know if any codes are
available for USB Device & USB Host testing for MPC8280.

am testing in FreeScale Code Warrior IDE

waiting for the reply ASAP

Regards,
Gurumurthy

-- 
Gurumurthy Gowdar

--0016364ef3c48e8219046ee44afc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear LinuxPPC members,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 am facing p=
roblem on writing USB device port driver for MPC8280,when i connect it to t=
he host PC through USB cable .device descriptor is happening host is settin=
g the address but device configuration is not happening properly...it hangs=
 there in USB busy handler.<br>
<br><br>below is the output of the snippet in hyperterminal for usb debuggi=
ng <br><br>Debug statements<br><br>GetDescriptor request length =3D 0x40<br=
>Device Descriptor...<br>bd status =3D 3ec0<br>=A0In TX USB event register =
=3D 108<br>
Recieved PID token =3D 0x3cc0<br>USB:SetAddress 2<br>bd status =3D 3800<br>=
bd status =3D 3ac0<br>=A0In TX USB event register =3D 108<br>GetDescriptor =
request length =3D 0x12<br>Device Descriptor...<br>bd status =3D 3ec0<br>=
=A0In TX USB event register =3D 109<br>
Recieved PID token =3D 0x3cc0<br>In USB_BUSY HANDLER : 0x108<br><br>it hang=
s in usb busy handler , am feeling data pid toggling may be the issue. <br>=
<br>please help me out to sort this issue....let me know if any codes are a=
vailable for USB Device &amp; USB Host testing for MPC8280.<br>
<br>am testing in FreeScale Code Warrior IDE<br><br>waiting for the reply A=
SAP<br><br>Regards,<br>Gurumurthy<br clear=3D"all"><br>-- <br>Gurumurthy Go=
wdar<br>

--0016364ef3c48e8219046ee44afc--
