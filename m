Return-Path: <mitsutaka.amano@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 865CDB7102
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Jan 2011 12:16:01 +1100 (EST)
Received: by wyi11 with SMTP id 11so3659434wyi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 23 Jan 2011 17:15:56 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 24 Jan 2011 10:15:56 +0900
Message-ID: <AANLkTin0RHAF8ieFqv12dFfOr_N3g3w6VVUTGOvH47uq@mail.gmail.com>
Subject: About mpc85xx flash memory allocation
From: Mitsutaka Amano <mitsutaka.amano@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I'm testing the ppc platform is based on mpc85xx. 256MB Flash memory
has been installed. Then I found this entries.

/proc/vmallocinfo
~~~
0xc9100000-0xd9101000 268439552 of_flash_probe+0x290/0x814 ioremap

physmap_of allocated 268MB over to the vmalloc. vmalloc space is tight.

Why does we need mpc platforms to flash memory allocation? I know
other architectures don't allocate to the vmalloc.
The design of the hardware? or Is there the way to use the flash
memory without vmalloc?

Thanks,
Mitsutaka
