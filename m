Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0146.outbound.protection.outlook.com [65.55.169.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F5681A0E80
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 04:58:06 +1100 (AEDT)
Message-ID: <1422640667.10544.164.camel@freescale.com>
Subject: Re: AW: SPE & Interrupt context (was how to make use of SPE
 instructions)
From: Scott Wood <scottwood@freescale.com>
To: Gabriel Paubert <paubert@iram.es>
Date: Fri, 30 Jan 2015 11:57:47 -0600
In-Reply-To: <20150130104126.GB29904@visitor2.iram.es>
References: <12EF8D94C6F8734FB2FF37B9FBEDD1735F915B69@EXCHANGE.collogia.de>
 <1422418883.10544.73.camel@freescale.com>
 <12EF8D94C6F8734FB2FF37B9FBEDD1735F9160AA@EXCHANGE.collogia.de>
 <1422578995.10544.138.camel@freescale.com>
 <12EF8D94C6F8734FB2FF37B9FBEDD1735F916CCB@EXCHANGE.collogia.de>
 <20150130084945.GA27784@visitor2.iram.es>
 <12EF8D94C6F8734FB2FF37B9FBEDD1735F916DA3@EXCHANGE.collogia.de>
 <20150130104126.GB29904@visitor2.iram.es>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Markus Stockhausen <stockhausen@collogia.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-01-30 at 11:41 +0100, Gabriel Paubert wrote:
> By the way, I wonder where the SAVE_EVR/REST_EVR macros are used. I only
> see the definitions, no use in a 3.18 source tree.

SAVE_EVR is used by SAVE_2EVRs, which is used by SAVE_4EVRS, etc.

The 32EVRS version is used in load_up_spe() and kvm_save_guest_spe().

-Scott
