Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from stl-smtpout-01.boeing.com (stl-smtpout-01.boeing.com
 [130.76.96.56])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "stl-smtpout-01.boeing.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id F085EB6F68
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 12:48:24 +1100 (EST)
From: "Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "michaele@au1.ibm.com"
 <michaele@au1.ibm.com>, Paul Mackerras <paulus@samba.org>
Date: Thu, 1 Dec 2011 19:48:05 -0600
Subject: Re: [PATCH 10/10] powerpc/mpic: Add in-core support for cascaded MPICs
Message-ID: <CDCF68E8-7EF4-4ED7-A1FA-2A2CE74287CB@boeing.com>
References: <1322593117-29938-1-git-send-email-Kyle.D.Moffett@boeing.com>
 <1322593117-29938-11-git-send-email-Kyle.D.Moffett@boeing.com>
 <1322722788.5215.3.camel@concordia>
In-Reply-To: <1322722788.5215.3.camel@concordia>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

I fixed the 3 issues that Paul and Michael reported and I can provide them
to you two different ways, however you would prefer.  I can also send the
patches via email if that's more convenient.

Option 1: Squashed into the the original patches for bisectability:
  git://opensource.exmeritus.com/hww-1u-1a/linux.git mpc85xx/mpic-and-stuff

Option 2: As a fixup patch on the end:
  git://opensource.exmeritus.com/hww-1u-1a/linux.git mpc85xx/mpic-and-stuff=
-fixup

You can also use HTTP if you would prefer:
  http://opensource.exmeritus.com/git/hww-1u-1a/linux.git

Cheers,
Kyle Moffett

--
Curious about my work on the Debian powerpcspe port?
I'm keeping a blog here: http://pureperl.blogspot.com/
