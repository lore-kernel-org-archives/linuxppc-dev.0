Return-Path: <dceravigupta@gmail.com>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179]) by ozlabs.org (Postfix) with ESMTP id 6F0DFB6ED0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Jul 2010 23:14:12 +1000 (EST)
Received: by pxi2 with SMTP id 2so1058255pxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Jul 2010 06:14:10 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 28 Jul 2010 18:44:10 +0530
Message-ID: <AANLkTikVrftUUC2W+NgWyZi6cc4H4c+mPza9MfsDKuxF@mail.gmail.com>
Subject: Memory Mapping Buffers smaller than page size?
From: Ravi Gupta <dceravigupta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=00163646c7a8b1ca03048c72644d
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00163646c7a8b1ca03048c72644d
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am new to linux device drivers development. I have created 16 buffers of
size 256 bytes each(using kmalloc()) in my device driver code. I want to
memory map these buffers to user space. Now is it possible to memory map
these buffer(16*256 = 4096 = 1 page on 32 bit linux) into a single page in
user space OR i have to map them in individual pages in user space? Note,
all the buffers may not be stored in continuous memory location.

Thanks in advance
Ravi Gupta

--00163646c7a8b1ca03048c72644d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am new to linux device drivers development. I have created 16 =
buffers of size 256 bytes each(using kmalloc()) in my device driver code. I=
 want to memory map these buffers to user space. Now is it possible to memo=
ry map these buffer(16*256 =3D 4096 =3D 1 page on 32 bit linux) into a sing=
le page in user space OR i have to map them in individual pages in user spa=
ce? Note, all the buffers may not be stored in continuous memory location.<=
br>
<br>Thanks in advance<br>Ravi Gupta<br>

--00163646c7a8b1ca03048c72644d--
