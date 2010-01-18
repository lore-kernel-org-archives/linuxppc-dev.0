Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 01315B7C94
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jan 2010 23:32:29 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0ICThuw026313
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2010 05:29:43 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o0ICWD4R250944
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2010 05:32:17 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0ICWAdR004137
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2010 05:32:10 -0700
Date: Mon, 18 Jan 2010 07:32:06 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch
Message-ID: <20100118123206.GD7484@zod.rchland.ibm.com>
References: <1263797148.724.484.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1263797148.724.484.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@lists.ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 18, 2010 at 05:45:48PM +1100, Benjamin Herrenschmidt wrote:
>Hi Linus !
>
>A tad late due to me slacking and leaving the patches take dust in
>patchwork for a bit too long, but here are a few bug fixes for powerpc
>and a bunch of defconfig freshen ups for some of our embedded platforms.

You missed my defconfig updates.  I sent you a pull request 2 weeks ago.

http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-January/079309.html

Those are still sitting in that tree on that branch if someone wanted to pull
them directly.

josh
