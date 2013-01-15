Return-Path: <vneethv@gmail.com>
Received: from mail-vc0-f170.google.com (mail-vc0-f170.google.com
 [209.85.220.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ABFF62C0090
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2013 00:05:02 +1100 (EST)
Received: by mail-vc0-f170.google.com with SMTP id fl11so64458vcb.29
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2013 05:05:00 -0800 (PST)
MIME-Version: 1.0
From: Vineeth <vneethv@gmail.com>
Date: Tue, 15 Jan 2013 18:34:39 +0530
Message-ID: <CAFbQSaDmDfcsV03w5jOX-cSC-jr4d4GXk8rkzxs5QZeRd2z+-Q@mail.gmail.com>
Subject: Issue with USB Mass storage on P5020
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=14dae9d24a1cbf510304d3536803
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--14dae9d24a1cbf510304d3536803
Content-Type: text/plain; charset=ISO-8859-1

When i connect my 500GB seagate HD on a P5020DS, its not getting mounted.

This is the dmesg log;
am i supposed to change some configuration ?

/ # dmesg

usb 1-1: new high speed USB device using fsl-ehci and address 5
usb 1-1: configuration #1 chosen from 1 choice
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning

do_scsi_scan_host

scsi 2:0:0:0: Direct-Access     Seagate  Expansion        0219 PQ: 0 ANSI: 6
sd 2:0:0:0: Attached scsi generic sg0 type 0
usb 1-1: USB disconnect, address 5
sd 2:0:0:0: [sda] the result =  65536
usb-storage: device scan complete
sd 2:0:0:0: [sda] sense_valid = 0
sd 2:0:0:0: [sda] the result =  65536
sd 2:0:0:0: [sda] sense_valid = 0
sd 2:0:0:0: [sda] the result =  65536
sd 2:0:0:0: [sda] sense_valid = 0
*sd 2:0:0:0: [sda] READ CAPACITY failed*
sd 2:0:0:0: [sda] Result: hostbyte=0x01 driverbyte=0x00
sd 2:0:0:0: [sda] Sense not available.
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: ea 0d 20 84
sd 2:0:0:0: [sda] Assuming drive cache: write through
sd 2:0:0:0: [sda] the result =  65536
sd 2:0:0:0: [sda] sense_valid = 0
sd 2:0:0:0: [sda] the result =  65536
sd 2:0:0:0: [sda] sense_valid = 0
sd 2:0:0:0: [sda] the result =  65536
sd 2:0:0:0: [sda] sense_valid = 0
*sd 2:0:0:0: [sda] READ CAPACITY failed  *
sd 2:0:0:0: [sda] Result: hostbyte=0x01 driverbyte=0x00
sd 2:0:0:0: [sda] Sense not available.
sd 2:0:0:0: [sda] Assuming drive cache: write through
sd 2:0:0:0: [sda] Attached SCSI disk
/ #
/ #
/ #
-- VISUAL --

--14dae9d24a1cbf510304d3536803
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

When i connect my 500GB seagate HD on a P5020DS, its not getting mounted.<b=
r><br>This is the dmesg log;<br>am i supposed to change some configuration =
?<br><br>/ # dmesg<br><br>usb 1-1: new high speed USB device using fsl-ehci=
 and address 5<br>


usb 1-1: configuration #1 chosen from 1 choice<br>scsi2 : SCSI emulation fo=
r USB Mass Storage devices<br>usb-storage: device found at 5<br>usb-storage=
: waiting for device to settle before scanning<br><br>do_scsi_scan_host<br>


<br>scsi 2:0:0:0: Direct-Access=A0=A0=A0=A0 Seagate=A0 Expansion=A0=A0=A0=
=A0=A0=A0=A0 0219 PQ: 0 ANSI: 6<br>sd 2:0:0:0: Attached scsi generic sg0 ty=
pe 0<br>usb 1-1: USB disconnect, address 5<br>sd 2:0:0:0: [sda] the result =
=3D=A0 65536<br>usb-storage: device scan complete<br>


sd 2:0:0:0: [sda] sense_valid =3D 0<br>sd 2:0:0:0: [sda] the result =3D=A0 =
65536<br>sd 2:0:0:0: [sda] sense_valid =3D 0<br>sd 2:0:0:0: [sda] the resul=
t =3D=A0 65536<br>sd 2:0:0:0: [sda] sense_valid =3D 0<br><b>sd 2:0:0:0: [sd=
a] READ CAPACITY failed</b><br>


sd 2:0:0:0: [sda] Result: hostbyte=3D0x01 driverbyte=3D0x00<br>sd 2:0:0:0: =
[sda] Sense not available.<br>sd 2:0:0:0: [sda] Write Protect is off<br>sd =
2:0:0:0: [sda] Mode Sense: ea 0d 20 84<br>sd 2:0:0:0: [sda] Assuming drive =
cache: write through<br>


sd 2:0:0:0: [sda] the result =3D=A0 65536<br>sd 2:0:0:0: [sda] sense_valid =
=3D 0<br>sd 2:0:0:0: [sda] the result =3D=A0 65536=A0 <br>sd 2:0:0:0: [sda]=
 sense_valid =3D 0=A0 <br>sd 2:0:0:0: [sda] the result =3D=A0 65536=A0 <br>=
sd 2:0:0:0: [sda] sense_valid =3D 0=A0 <br>


<b>sd 2:0:0:0: [sda] READ CAPACITY failed=A0 </b><br>sd 2:0:0:0: [sda] Resu=
lt: hostbyte=3D0x01 driverbyte=3D0x00 <br>sd 2:0:0:0: [sda] Sense not avail=
able. <br>sd 2:0:0:0: [sda] Assuming drive cache: write through <br>sd 2:0:=
0:0: [sda] Attached SCSI disk <br>


/ #=A0 <br>/ #=A0 <br>/ #<br>-- VISUAL --=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0<div id=3D":2ut">=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br></div>

--14dae9d24a1cbf510304d3536803--
