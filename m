Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw2.extranet.tce.com (dmzraw2.extranet.tce.com
	[157.254.234.138]) by ozlabs.org (Postfix) with ESMTP id BC39167A64
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2005 00:05:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 4 Apr 2005 16:05:36 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0D2A@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: RE: RE : How to read/write in flash memories (MTD)?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bonjour J=E9r=E9mie,

Your mail is a bit off-topic on the linuxppc-dev list. A better list =
would
be linux-mtd. Check out: http://www.linux-mtd.infradead.org

>Your reply confirmed my feeling. So I've decided to use the MTD but =
with my >own driver as I found in a tutorial. So I made the file =
(module) >/drivers/mtd/maps/myBoardFlash.c in order to support my 2 =
flash memories. >You can see the code below, but once again (sorry...) I =
have some questions >and doubts on it.=20
>1- Is that driver correct for my case?=20
>2- Are those R/W routines are usable?
>3- In our application we want to download source code and achievable =
code >using Ethernet (so R/W operations). Do I need a filesystem for =
that as JFFS2 ?=20

yes, or any other kind of filesystem on top of "MTD block", but this can =
be=20
unreliable. One solution can be also to use raw partitions to store =
data.

>4- Giving this driver, what is the process to use my R/W routines (if =
they >are correct...) from the user space?

To use your R/W routines, you can use "MTD char" support.=20
See fcp.c (from MTD CVS or ftp site) for an example.


Regards
--=20
Stephane
