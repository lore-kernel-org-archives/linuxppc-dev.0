Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 59E26B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Sep 2010 23:44:45 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8DDP42c031604
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Sep 2010 09:25:04 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8DDidCY2248782
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Sep 2010 09:44:39 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8DDid5S019236
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Sep 2010 09:44:39 -0400
Date: Mon, 13 Sep 2010 09:44:36 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] APM821xx: Add support for new SoC APM821xx
Message-ID: <20100913134436.GA31548@zod.rchland.ibm.com>
References: <1283464653-18492-1-git-send-email-tmarri@apm.com>
	<20100903020851.GC29732@hansolo.jdub.homelinux.org>
	<197d4509c0b1206ce2d686c03701a6b4@mail.gmail.com>
	<20100905222340.GC2150@lixom.net>
	<01bb9090932e6984c887273078fd586f@mail.gmail.com>
	<20100906154526.GA515@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100906154526.GA515@lixom.net>
Cc: Tirumala Marri <tmarri@apm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 06, 2010 at 10:45:26AM -0500, Olof Johansson wrote:
>On Sun, Sep 05, 2010 at 10:19:53PM -0700, Tirumala Marri wrote:
>> >
>> > Then the device tree identifier, and the cpu setup functions, etc,
>> > should indicate
>> > 464, not APM821xx.
>> This is new SoC based on 464 cpu core. All the previous SoC device tree
>> CPU portion uses SoC name.
>
>Hm, you're right. Confusing.
>
>Still, the cpu setup functions would make more sense to have the core
>name in, not the SoC name. Especially since multiple SoC families might
>use the same core, etc.

In theory.  In practice, it just makes it a damn mess.  I'd rather leave
it as-is until we can get a good split-out of the core variants and what
their setup functions might require.  Starting with just this SoC and not
fixing everything else is going to be confusing and probably wrong.

josh
