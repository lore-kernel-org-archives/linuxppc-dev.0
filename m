Return-Path: <sprasad@bivio.net>
Received: from corpexc01.corp.networkrobots.com (nofear-snat.bivio.net
	[216.142.75.231]) by ozlabs.org (Postfix) with ESMTP id 46469DE5E7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Jul 2008 06:47:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: linux boot sequence
Date: Fri, 11 Jul 2008 13:47:14 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D702B6409A@corpexc01.corp.networkrobots.com>
In-Reply-To: <mailman.1640.1215763007.2883.linuxppc-embedded@ozlabs.org>
References: <mailman.1640.1215763007.2883.linuxppc-embedded@ozlabs.org>
From: "Siva Prasad" <sprasad@bivio.net>
To: <rwehbi@wirecom-tech.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Well!... You can pass the size as part of the OF memory=3D<>.

Typically your boot loader should detect the amount of memory on the
system and update the OF dtb to reflect the available memory.

You may also tweak the kernel yourself to autodetect, instead of reading
from the OF. How ever, I would recommend the previous approach.

- Siva


Date: Fri, 11 Jul 2008 08:34:54 +0200
From: "Rami WEHBI" <rwehbi@wirecom-tech.com>
Subject: linux boot sequence
To: <linuxppc-embedded@ozlabs.org>
Message-ID:
=09
<D3C541E264C021479BFB60B3B790C0FB497014@etoilenoire.STARWARS.local>
Content-Type: text/plain; charset=3D"iso-8859-1"


Hi all,
=20
    I am using the ppc405 and I would like to know, how does linux on
this architect detect the available memory size in details !!!
        is it a parameter passed to linux at startup by the boot loader
??
        is it an automatic detection ?? what are the steps to accomplish
this job then ???
=20
Best regards to all,
=20
Rami
=20



Rami WEHBI =09
Recherche & D?veloppement =09
T?l :	 +33 2 36 56 86 00=09
Fax :	 +33 2 36 56 86 01=09
www.wirecom-tech.com=09

  <http://www.wirecom-tech.com> =09

WIRECOM Technologies=20
135, Rue Jacques Charles
45166 Olivet
=09
