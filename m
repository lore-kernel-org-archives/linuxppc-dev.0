Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B66C433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Mar 2022 23:03:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KTzNj1Wffz3bb2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Apr 2022 10:03:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4KTzNB1wLQz2yHD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2022 10:02:32 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 22VN0OVO024243;
 Thu, 31 Mar 2022 18:00:24 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 22VN0Nur024238;
 Thu, 31 Mar 2022 18:00:23 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 31 Mar 2022 18:00:22 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] powerpc/boot: Build wrapper for an appropriate CPU
Message-ID: <20220331230022.GZ614@gate.crashing.org>
References: <20220330112437.540214-1-joel@jms.id.au>
 <e0776e34-7efa-f42c-c194-1fc3fc5cf445@csgroup.eu>
 <CACPK8XdMiLFRpz7zAAVyGJzF4DiXrCK0WdKLxQ24e3KvFgdyow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XdMiLFRpz7zAAVyGJzF4DiXrCK0WdKLxQ24e3KvFgdyow@mail.gmail.com>
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 30, 2022 at 11:39:13AM +0000, Joel Stanley wrote:
> Last one wins as far as -mcpu lines goes, from a quick test.

This is true yes.  It is true for GCC options in general.


Segher
