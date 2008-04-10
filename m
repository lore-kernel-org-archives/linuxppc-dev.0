Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 46517DE859
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 21:57:24 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3ABtJCH014603
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 07:55:19 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3ABvLUi207518
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 05:57:21 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3ABvLiK013433
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 05:57:21 -0600
Date: Thu, 10 Apr 2008 06:55:18 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH 0 of 3] KVM for PowerPC 440
Message-ID: <20080410065518.46979767@zod.rchland.ibm.com>
In-Reply-To: <patchbomb.1207601611@localhost.localdomain>
References: <patchbomb.1207601611@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kvm-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	kvm-ppc-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 07 Apr 2008 15:53:31 -0500
Hollis Blanchard <hollisb@us.ibm.com> wrote:

> Implement initial support for KVM for PowerPC 440. There are just two small
> prerequisite patches, and then the bulk of the code can't be split easily.
> 
> Please review; I would like to submit these for 2.6.26. There is plenty of work
> to do, both functional and optimization, but this code is sufficient to run
> unmodified 440 Linux guests on a 440 Linux host. What's your favorite bike shed
> color?

Who's tree are you looking to get this patch set into?

josh
