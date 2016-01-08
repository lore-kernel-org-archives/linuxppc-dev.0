Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A0FA1A0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 12:34:43 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 8 Jan 2016 11:34:42 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 328603578055
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 12:34:39 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u081YLhL18481312
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jan 2016 12:34:29 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u081Y6Vv028702
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jan 2016 12:34:06 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Michael Neuling <mikey@neuling.org>, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Michal Marek <mmarek@suse.com>
Subject: Re: Build failure: -Wno-unused-const-variable DNE on old GCC
In-reply-to: <10821353.mAlCTdTQBC@wuerfel>
References: <20160107185406.GA65420@google.com> <10821353.mAlCTdTQBC@wuerfel>
Date: Fri, 08 Jan 2016 12:33:41 +1100
Message-Id: <1452216731-sup-9495@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>

As suggested by Brian we might also gate the -Werror with
CONFIG_PPC_WERROR, but that can be in a separate commit.
