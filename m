Message-Id: <200112040050.fB40o6610661@mailout6-0.nyroc.rr.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Paul Ruhland <pruhland@rochester.rr.com>
To: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
Subject: Re: JFFS
Date: Mon, 3 Dec 2001 19:50:06 -0500
References: <sc0b75df.064@mail.frequentis.com>
In-Reply-To: <sc0b75df.064@mail.frequentis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Gerhard.

> I try to get rum mtd and jffs, mtd semmd to work fin, I get the line that
> physmap worked, but now I'm looking for the needed utils (erase and
> mkfs.jffs(2)) for the MPC860. Any ideas whre I could download it? Or any
> patches for the makefile?
>

'erase', 'mkfs.jffs', etc. are located in the 'util' directory of the mtd
source tree.  Instructions regarding compile the utils is contained in the
README in that directory.

If the mtd stuff came with your kernel the util directory may be in the linux
source tree...I don't know off hand since I used the mtd source.

--
Paul Ruhland
pruhland@rochester.rr.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
