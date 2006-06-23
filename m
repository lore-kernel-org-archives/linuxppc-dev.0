Return-Path: <yang.reeve@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.204])
	by ozlabs.org (Postfix) with ESMTP id 5D853679FF
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 11:12:13 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id v1so207557nzb
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 18:12:12 -0700 (PDT)
Message-ID: <198592450606221806yfe1e489wf29ebefd3bc264b@mail.gmail.com>
Date: Fri, 23 Jun 2006 01:06:00 +0000
From: "Reeve Yang" <yang.reeve@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Q about i2c controller on mpc8245
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5897_29232056.1151024760749"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_5897_29232056.1151024760749
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I'm new to this list and wish to get help from it since I'm currently
developing a switch box based on mpc8245, the kernel I'm using is 2.6.14.

Now I'm trying to bring up the I2C controller then I2C devices. Is fsl-i2c
the driver for I2C controller of MPC8245? I enabled that driver and it was
installed, but there is no any device found. Why is it like that? Following
are the dump from sysfs.

/ # systool -b platform -d
Bus = "platform"

  Device = "serial8250"
  Device = "serial8250.0"
  Device = "serial8250.1"

/ # systool -b platform -D
Bus = "platform"

  Driver = "fsl-i2c"

  Driver = "serial8250"
    Devices using "serial8250" are:
      Device = "serial8250"

      Device = "serial8250.0"

      Device = "serial8250.1"

In the booting sequence, I got following error message:

PCI: Probing PCI hardware
PCI: Cannot allocate resource region 1 of device 0000:00:00.0
fsl-i2c.1: failed to claim resource 0
unable to register device 0
fsl-dma.0: failed to claim resource 0
unable to register device 1
fsl-dma.1: failed to claim resource 0
unable to register device 2

Does this error make device undetected? What might be the reason for above
errors? I'd appreciate if you could shed some lights.

Regards,

- Reeve

------=_Part_5897_29232056.1151024760749
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br>
<br>
I'm new to this list and wish to get help from it since I'm currently
developing a switch box based on mpc8245, the kernel I'm using is
2.6.14.<br>
<br>
Now I'm trying to bring up the I2C controller then I2C devices. Is
fsl-i2c the driver for I2C controller of MPC8245? I enabled that driver
and it was installed, but there is no any device found. Why is it like
that? Following are the dump from sysfs.<br>
<br>
/ # systool -b platform -d<br>
Bus = &quot;platform&quot;<br>
<br>
&nbsp; Device = &quot;serial8250&quot;<br>
&nbsp; Device = &quot;serial8250.0&quot;<br>
&nbsp; Device = &quot;serial8250.1&quot;<br>
<br>
/ # systool -b platform -D<br>
Bus = &quot;platform&quot;<br>
<br>
&nbsp; Driver = &quot;fsl-i2c&quot;<br>
<br>
&nbsp; Driver = &quot;serial8250&quot;<br>
&nbsp;&nbsp;&nbsp; Devices using &quot;serial8250&quot; are:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device = &quot;serial8250&quot;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device = &quot;serial8250.0&quot;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device = &quot;serial8250.1&quot;<br>
<br>
In the booting sequence, I got following error message:<br>
<br>
PCI: Probing PCI hardware<br>
PCI: Cannot allocate resource region 1 of device 0000:00:00.0<br>
fsl-i2c.1: failed to claim resource 0<br>
unable to register device 0<br>
fsl-dma.0: failed to claim resource 0<br>
unable to register device 1<br>
fsl-dma.1: failed to claim resource 0<br>
unable to register device 2<br>
<br>
Does this error make device undetected? What might be the reason for above errors? I'd appreciate if you could shed some lights.<br>
<br>
Regards,<br>
<br>
- Reeve<br>

------=_Part_5897_29232056.1151024760749--
