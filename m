Return-Path: <terren.chow@gmail.com>
Received: from mail-iw0-f201.google.com (mail-iw0-f201.google.com
	[209.85.223.201]) by ozlabs.org (Postfix) with ESMTP id 778AEB7D15
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Apr 2010 16:34:06 +1000 (EST)
Received: by iwn39 with SMTP id 39so6490489iwn.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Apr 2010 23:34:04 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Apr 2010 14:34:04 +0800
Message-ID: <q2t9faa26521004132334ta3e05513u2b9b569c47fbe212@mail.gmail.com>
Subject: Questions about creating a OF platform device
From: Terren Chow <terren.chow@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016e64757227ac49504842c90a7
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e64757227ac49504842c90a7
Content-Type: text/plain; charset=ISO-8859-1

Dear all,
    I'm new to PPC Linux development. Recently I'm learning how to write a
Linux device driver on MPC5121 based embedded system. I'm just confused
about the OF related code in the kernel.
    I know in the Linux device driver model, a driver is attached to a
device through the bus_type methods. For example, the  platform_driver is
attached to a platform device through the register_platform_driver() method.
This method will scan over the device list in the bus, and perform probe()
method when the match() method return ok.
   My question is, in PPC Linux, there is a structure named *
of_platform_driver* which is similar to *platform_driver* and there is also
a bus_type named *of_platform_bus_type* which is similar to *
platform_bus_type*. But I can't find any information about the structure
of_platform_device. How do the kernel create the of_platform_device and
place them into the device list in the *platform_bus_type* ? I search the
Internet and I can't find any information about this.Could anyone give me
some information so that I can find out the magic behind. Thanks!

-- 
Terren.Chow
College of Informatics, SCAU
Graduate Student
Lab of Embedded System and Wireless Sensor Network
MSN: terren.chow@hotmail.com

--0016e64757227ac49504842c90a7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear all,<br>=A0=A0=A0 I&#39;m new to PPC Linux development. Recently I&#39=
;m
 learning how to write a Linux device driver on MPC5121 based embedded=20
system. I&#39;m just confused about the OF related code in the kernel. <br>
=A0=A0=A0 I know in the Linux device driver model, a driver is attached to =
a=20
device through the bus_type methods. For example, the=A0 platform_driver=20
is attached to a platform device through the register_platform_driver()=20
method. This method will scan over the device list in the bus, and=20
perform probe() method when the match() method return ok. <br>
=A0=A0 My question is, in PPC Linux, there is a structure named <b>of_platf=
orm_driver</b>
 which is similar to <b>platform_driver</b> and there is also a bus_type
 named <b>of_platform_bus_type</b> which is similar to <b>platform_bus_type=
</b>.
 But I can&#39;t find any information about the structure=20
of_platform_device. How do the kernel create the of_platform_device and=20
place them into the device list in the <b>platform_bus_type</b> ? I=20
search the Internet and I can&#39;t find any information about this.Could a=
nyone give me some information so that I can find out the=20
magic behind. Thanks!<br clear=3D"all"><br>-- <br><font color=3D"#888888">T=
erren.Chow<br>College of Informatics, SCAU <br>Graduate
 Student<br>Lab of Embedded System and Wireless Sensor Network<br>MSN: <a h=
ref=3D"mailto:terren.chow@hotmail.com" target=3D"_blank">terren.chow@hotmai=
l.com</a></font><br>

--0016e64757227ac49504842c90a7--
