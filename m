Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id E46862C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 20:05:01 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 15911-02 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 11 Jul 2013 11:04:59 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH] powerpc/85xx: enable the math emulation for the
 corenet64_smp_defconfig
Date: Thu, 11 Jul 2013 11:04:06 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B72DF@saturn3.aculab.com>
In-Reply-To: <20130711092148.GB22910@pek-khao-d1.corp.ad.wrs.com>
References: <1373420992-25167-1-git-send-email-haokexin@gmail.com>
 <1373492403.8183.234@snotra>
 <20130711092148.GB22910@pek-khao-d1.corp.ad.wrs.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Kevin Hao" <haokexin@gmail.com>,
	"Scott Wood" <scottwood@freescale.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > It'd also be nice if we had an option to only include the portions
> > of math-emu that are known to be missing in some CPUs (excluding
> > CPUs that are missing the entire FPU, of course).  Besides its
> > effect on kernel image size, in my experience math-emu adds a
> > non-trivial amount of time to a kernel build.
>=20
> Sounds reasonable. I will give it a try.

It also ought to be possible to use the FPU when emulating the
missing instructions - rather than using the full 'soft' FPU.

	David
