Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205D7ECAAD8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Sep 2022 19:06:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MXnvD2YlVz3bqv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Sep 2022 05:06:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MXntn1HmHz30KY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2022 05:05:52 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 28LJ3oap025783;
	Wed, 21 Sep 2022 14:03:50 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 28LJ3oNq025782;
	Wed, 21 Sep 2022 14:03:50 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 21 Sep 2022 14:03:50 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64s: update cpu selection options
Message-ID: <20220921190350.GF25951@gate.crashing.org>
References: <20220921014103.587954-1-npiggin@gmail.com> <20220921014103.587954-2-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921014103.587954-2-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Sep 21, 2022 at 11:41:03AM +1000, Nicholas Piggin wrote:
> Update the 64s GENERIC_CPU option. POWER4 support has been dropped, so
> make that clear in the option name. The POWER5_CPU option is dropped
> because it's uncommon, and GENERIC_CPU covers it.
> 
> -mtune= before power8 is dropped because the minimum gcc version
> supports power8, and tuning is made consistent between big and little
> endian.
> 
> A 970 option is added for PowerPC 970 / G5 because they still have a
> user base, and -mtune=power8 does not generate good code for the 970.
> 
> This also updates the ISA versions document to add Power4/Power4+
> because I didn't realise Power4+ used 2.01.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

Cheers,


Segher
