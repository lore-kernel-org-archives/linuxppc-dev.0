Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4130P22q09zDrbS
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jun 2018 23:24:20 +1000 (AEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
References: <cover.1528423341.git.fthain@telegraphics.com.au>
 <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
 <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com>
 <m2h8mc4ejw.fsf@linux-m68k.org>
 <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com>
 <alpine.LNX.2.21.1806092140410.26@nippy.intranet>
Date: Sat, 09 Jun 2018 15:24:14 +0200
In-Reply-To: <alpine.LNX.2.21.1806092140410.26@nippy.intranet> (Finn Thain's
 message of "Sat, 9 Jun 2018 22:21:06 +1000 (AEST)")
Message-ID: <87a7s4854x.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Jun 09 2018, Finn Thain <fthain@telegraphics.com.au> wrote:

> There is no ABI issue AFAIK. The value of pmu_kind is visible to userland 
> only on powerpc. /dev/pmu and /proc/pmu/* do not exist on m68k.

Then why are PMU_68K_V1 and PMU_68K_V2 defined in the first place?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
