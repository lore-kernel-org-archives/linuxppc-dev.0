Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E3DABDDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 13:27:31 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8H3R8a8016441
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Sep 2007 23:27:08 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8H3R8vX465102
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Sep 2007 21:27:08 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8H3R8qj003325
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Sep 2007 21:27:08 -0600
Subject: Re: [PATCH] fix xmon input on 440
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070917025223.GG32725@localhost.localdomain>
References: <1189802687.20625.74.camel@basalt>
	<20070917025223.GG32725@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 16 Sep 2007 22:26:37 -0500
Message-Id: <1189999598.17593.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-09-17 at 12:52 +1000, David Gibson wrote:
> On Fri, Sep 14, 2007 at 03:44:47PM -0500, Hollis Blanchard wrote:
> > Implement udbg_getc() for 440, which fixes xmon input.
> > Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> 

I fixed up the whitespace issues and applied it to my tree.  Oh, and
comments don't need semi-colons ;)

josh
