Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 12E95DDDFF
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 23:22:11 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67DM8uZ013653
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 09:22:08 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67DLxM5147950
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 07:21:59 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67DLui2017507
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 07:21:59 -0600
Date: Mon, 7 Jul 2008 09:18:18 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RFC/PATCH] powerpc/bootwrapper: Allow user to specify
	additional default targets
Message-ID: <20080707091818.72d584fe@zod.rchland.ibm.com>
In-Reply-To: <fa686aa40807032351l631febe2h8d38a9eed1053b6b@mail.gmail.com>
References: <20080701175852.32575.39707.stgit@trillian.secretlab.ca>
	<fa686aa40807032351l631febe2h8d38a9eed1053b6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 4 Jul 2008 00:51:44 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> Anyone had a chance to look at this?  I think this could be used to
> eliminate a lot of the platform specific default targets in
> arch/powerpc/boot/Makefile by moving them into the defconfigs.  Josh,
> Kumar, what are your thoughts?

So for cases like Kilauea/Haleakala or Bamboo/Yosemite, you would
specify Yosemite in the bamboo defconfig?  Or?

I actually sort of prefer having a separate defconfig/CONFIG_YOSEMITE
(as an example) because it's much easier for an end user to figure out
if the board is supported or not.

I could be totally misunderstanding the intention of this patch though,
so I'll stop rambling and wait to see what the use case is.

josh
