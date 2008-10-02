Return-Path: <niklaus.giger@member.fsf.org>
Received: from viefep28-int.chello.at (viefep28-int.chello.at [62.179.121.48])
	by ozlabs.org (Postfix) with ESMTP id 771E9DDE00
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 15:12:19 +1000 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Added preliminary support for Netstal HCU4 board
Date: Thu, 2 Oct 2008 07:12:14 +0200
References: <200810011947.16543.niklaus.giger@member.fsf.org>
	<200810020014.20414.niklaus.giger@member.fsf.org>
	<20081002005208.GE25598@yookeroo.seuss>
In-Reply-To: <20081002005208.GE25598@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810020712.15088.niklaus.giger@member.fsf.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David

Am Donnerstag 02 Oktober 2008 02.52:08 schrieb David Gibson:
> That will work, but will lose comments, references, and other
> formatting, because it essentially compiles then decompiles the tree.
> You probably don't want to do that. =A0There's also an explicit
> conversion program, convert-dtsv0, which will preserve that
> not-significant-to-output, but useful for the reader information.

Thanks for providing me the hint. Using it, would surely  have been easier=
=20
than adding manually the comment again. However I using the search=20
"dtc dts-v1 syntax conversion script" didn't give me any hint and even in t=
he=20
the current  http://www.jdl.com/software/dtc.git I find no word in the=20
Documentation about convert-dtsv0.

Neither does it get installed when calling make install.

Therefore I would suggest you to add a small remark like this:

convert-dtsv0 is a small utility program which converts (DTS)
Device Tree Source from the obsolete version 0 to version 1. Version 1 DTS
files are marked by line "/dts-v1/;" at the top of the file.

Best regards

Niklaus
