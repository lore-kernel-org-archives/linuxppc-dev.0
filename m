Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Wolfgang Denk" <wd@denx.de>,
	"Flavio Pereira" <fpereira@azisa.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Linux on 8260 using ELDK..Help?!? 
Date: Wed, 4 Sep 2002 06:58:31 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFGEKFDLAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20020904134124.0F2AE11835@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Did you fix the IMMR mapping in PPCBoot? The  CFG_DEFAULT_IMMR  defi-
> nition  will  NOT  work with LInux; see the Linux memory map require-
> ments - You _must_ map the IMMR at 0xF0000000 or above.

If he got this far in the boot, the IMMR is working.

> > Warning: unable to open an initial console.
>
> Did you run the ELDK_MAKEDEV and ELDK_FIXPERM scripts as documented?

Looks like this is the problem....

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
