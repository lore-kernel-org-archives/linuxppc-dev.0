Return-Path: <prashantsmailcenter@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4BD8DB6F93
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Apr 2011 20:22:40 +1000 (EST)
Received: by iym7 with SMTP id 7so3653133iym.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Apr 2011 03:22:36 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 29 Apr 2011 15:52:36 +0530
Message-ID: <BANLkTi=VwXSCDKcynwvZP-D5Q=xaAXtzzg@mail.gmail.com>
Subject: Kernel cannot see PCI device on 460EX
From: Prashant Bhole <prashantsmailcenter@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=20cf30334815798b3804a20c0d1d
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--20cf30334815798b3804a20c0d1d
Content-Type: text/plain; charset=ISO-8859-1

Hi,
I have a custom made 460EX board. On that board u-boot can see a PCI device
but linux kernel cannot see it. What could be the problem?

On u-boot "pci  2" commands displays following device:
Scanning PCI devices on bus 2
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
02.00.00   0x1000     0x0072     Mass storage controller 0x00

And when linux is booted there is only one pci device (bridge):
#ls /sys/bus/pci/devices
0000:80:00.0


Thanks in advance.


-Prashant

--20cf30334815798b3804a20c0d1d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div>I have a custom made 460EX board. On that board u-boot can see a PC=
I device</div><div>but linux kernel cannot see it. What could be the proble=
m?</div><div><br></div><div>On u-boot &quot;pci =A02&quot; commands display=
s following device:</div>
<div><div>Scanning PCI devices on bus 2</div><div>BusDevFun =A0VendorId =A0=
 DeviceId =A0 Device Class =A0 =A0 =A0 Sub-Class</div><div>________________=
_____________________________________________</div><div>02.00.00 =A0 0x1000=
 =A0 =A0 0x0072 =A0 =A0 Mass storage controller 0x00</div>
<div><br></div><div>And when linux is booted there is only one pci device (=
bridge):</div><div><div>#ls /sys/bus/pci/devices</div><div>0000:80:00.0</di=
v></div><div><br></div><div><br></div><div>Thanks in advance.</div><div>
<br></div><div><br></div>-Prashant
</div>

--20cf30334815798b3804a20c0d1d--
