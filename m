Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0133.outbound.protection.outlook.com [157.56.110.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 211271A08FB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 08:32:11 +1100 (AEDT)
Message-ID: <1424727116.4698.2.camel@freescale.com>
Subject: Re: [PATCH 4/4] powerpc/mpic: remove unused functions
From: Scott Wood <scottwood@freescale.com>
To: Arseny Solokha <asolokha@kb.kras.ru>
Date: Mon, 23 Feb 2015 15:31:56 -0600
In-Reply-To: <87d256kry8.fsf@KB00016249.iskra.kb>
References: <1424084188-17097-1-git-send-email-asolokha@kb.kras.ru>
 <1424084188-17097-5-git-send-email-asolokha@kb.kras.ru>
 <1424307520.22020.5.camel@ellerman.id.au>
 <87d256kry8.fsf@KB00016249.iskra.kb>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: hongtao.jia@freescale.com, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-02-19 at 19:26 +0700, Arseny Solokha wrote:
>   + fsl_mpic_primary_get_version() is just a safe wrapper around
> fsl_mpic_get_version() for SMP configurations. While the latter is
> called explicitly for handling PIC initialization and setting up error
> interrupt vector depending on PIC hardware version, the former isn't
> used for anything.

It was meant to be used by http://patchwork.ozlabs.org/patch/233211/
which never got respun.  Hongtao, do you plan to revisit that patch?

-Scott
