Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347BFC43334
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jun 2022 17:34:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LSDD33w4lz3brW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jun 2022 03:34:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LSDCc1wsfz2xsr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2022 03:34:19 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 25LHVvY1008537;
	Tue, 21 Jun 2022 12:31:57 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 25LHVtN5008531;
	Tue, 21 Jun 2022 12:31:55 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 21 Jun 2022 12:31:55 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nathan Lynch <nathanl@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] powerpc/pseries: hvcall.h: add H_WATCHDOG opcode, H_NOOP return code
Message-ID: <20220621173155.GQ25951@gate.crashing.org>
References: <20220602175353.68942-1-cheloha@linux.ibm.com> <20220602175353.68942-2-cheloha@linux.ibm.com> <87a6a6nkit.fsf@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6a6nkit.fsf@linux.ibm.com>
User-Agent: Mutt/1.4.2.3i
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: wvoigt@us.ibm.com, linux-watchdog@vger.kernel.org, aik@ozlabs.ru, Scott Cheloha <cheloha@linux.ibm.com>, vaishnavi@linux.ibm.com, npiggin@gmail.com, tzungbi@kernel.org, brking@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, linux@roeck-us.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

On Tue, Jun 21, 2022 at 09:44:42AM -0500, Nathan Lynch wrote:
> Not a problem to fix in your series, but I guess these should be
> parenthesized i.e.
> 
> #define H_P7		(-60)
> #define H_P8		(-61)
> #define H_P9		(-62)
> #define H_NOOP		(-63)

Why?  It does not change the semantics of any correct code.  For what
incorrect code will it make the diagnostics clearer?


Segher
