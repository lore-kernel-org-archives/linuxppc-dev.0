Return-Path: <kyle@moffetthome.net>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
 [209.85.210.43]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 51E70B7212
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2011 14:40:42 +1100 (EST)
Received: by pzk34 with SMTP id 34so14358456pzk.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2011 19:40:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4EC1D15E.3010800@freescale.com>
References: <4E42AB6F.1050900@freescale.com>
 <1320883399-15911-1-git-send-email-Kyle.D.Moffett@boeing.com>
 <FF2BF3F3-1158-4747-AEEC-03D6A7C462D9@kernel.crashing.org>
 <C0DED343-76A8-457E-BF54-E52DFCAC83A8@boeing.com>
 <58FDDDA5-26C4-493B-A00D-81DD94A5C26A@kernel.crashing.org>
 <20111110165455.GE11983@schlenkerla.am.freescale.net>
 <15AB1C61-181F-4454-AF99-772B73DE0AA5@boeing.com>
 <1320986410.21206.48.camel@pasglop>
 <4A0007C2-1C2C-4162-98E8-ACCA4E673AFE@boeing.com>
 <4EC1D15E.3010800@freescale.com>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Mon, 14 Nov 2011 22:40:18 -0500
Message-ID: <CAGZ=bqKm8dctvYdHesaxAXxgSUmOBhExCwq=J9vc+QYCzaoJiw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/17] powerpc/e500: separate e500 from e500mc
To: Tabi Timur-B04825 <B04825@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>, "Moffett,
 Kyle D" <Kyle.D.Moffett@boeing.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 14, 2011 at 21:41, Tabi Timur-B04825 <B04825@freescale.com> wrote:
> Moffett, Kyle D wrote:
>>the PPC Book-E spec documents that the pagesize is an even multiple
>> of the cacheline size and the cachelines are always page-aligned.
>
> cachelines are page aligned?

Whoops, good catch.  That should have been:

"the PPC Book-E spec documents that the pagesize is an even multiple
of the cacheline size and that the pages are always cacheline-aligned."

Thanks!

Cheers,
Kyle Moffett

-- 
Curious about my work on the Debian powerpcspe port?
I'm keeping a blog here: http://pureperl.blogspot.com/
