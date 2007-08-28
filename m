Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 44F3DDDE10
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 00:33:37 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7SEXXCC007698
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 10:33:33 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7SEXVJU297846
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 08:33:32 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7SEXV9L003795
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 08:33:31 -0600
Date: Tue, 28 Aug 2007 09:33:29 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] Use strcasecmp() rather than strncasecmp() when
	determining device node compatibility.
Message-ID: <20070828093329.575f9b9e@weaponx.rchland.ibm.com>
In-Reply-To: <20070820163659.GB29912@ld0162-tx32.am.freescale.net>
References: <20070820163619.GA29889@ld0162-tx32.am.freescale.net>
	<20070820163659.GB29912@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 20 Aug 2007 11:36:59 -0500
Scott Wood <scottwood@freescale.com> wrote:

> The current code assumes "foo-bar" must always be compatible with a node
> compatible with "foo", which breaks device trees where this is not so.
> 
> The "case" part is also wrong according to Open Firmware, but it's more
> likely to have drivers and/or device trees depending on it, and thus
> needs to be handled more carefully.

After wasting about an hour with git bisect, I finally realized that
this patch "caught" an error in the walnut patches I'm working on (by
making it not boot). So thanks!

josh
