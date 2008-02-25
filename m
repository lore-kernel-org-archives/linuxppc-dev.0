Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2DE7BDDDEC
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 15:35:39 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1P4ZY8U016217
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 23:35:34 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1P4ZYpr128808
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 21:35:34 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1P4ZYS0030796
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 21:35:34 -0700
Date: Sun, 24 Feb 2008 22:34:43 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Use aliases instead of linux,network-index on Ebony
Message-ID: <20080224223443.6f84d073@zod.rchland.ibm.com>
In-Reply-To: <20080225003339.GB16071@localhost.localdomain>
References: <20080225003339.GB16071@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 25 Feb 2008 11:33:39 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> This patch alters the Ebony bootwrapper to use the new preferred
> method of using aliases to work out which MAC address to attach to
> which ethernet device node, rather than the old method based on the
> linux,network-index property.

I like it.  But do we have this new preferred method documented
somewhere?  Doesn't seem to be in booting-without-of.txt.  It probably
should be added there, and reference to the linux,network-index
property removed if this is really preferred now.  Can you add
something to this patch for that?

josh
