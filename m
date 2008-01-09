Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A9EB5DDFB7
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 06:11:19 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m09I8WKX000342
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 13:08:32 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m09JBDZf067892
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 12:11:14 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m09JBDJU006155
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jan 2008 12:11:13 -0700
Date: Wed, 9 Jan 2008 13:10:55 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Base Warp Platform support
Message-ID: <20080109131055.7f277528@zod.rchland.ibm.com>
In-Reply-To: <478504BF.2000908@pikatech.com>
References: <477F0C46.6080900@pikatech.com> <1199517639.7291.45.camel@pasglop>
	<4783C7DD.1050202@pikatech.com> <478504BF.2000908@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 09 Jan 2008 12:30:39 -0500
Sean MacLennan <smaclennan@pikatech.com> wrote:

> So no comments? I got it perfect the first time :D

Not quite.. :)

The way you have the patches laid out right now will break compiling
and git bisecting.

Could you take these and roll them up into distinct patches that can
all apply without breaking a compile individually?  I recommend doing
it this way:

Patch 1) platform files in arch/powerpc/platforms/44x/
Patch 2) DTS
Patch 3) boot files in arch/powerpc/boot
Patch 4) defconfig

or something along those lines.

That way we can apply them in that order, nothing breaks for the
compile, and they aren't scattered about.  If you start a new email
thread with those I think most of it looked fairly good otherwise.
