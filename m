Return-Path: <timur.tabi@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id D867CB708B
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Nov 2010 02:45:24 +1100 (EST)
Received: by gyf2 with SMTP id 2so1945546gyf.15
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Nov 2010 07:45:23 -0800 (PST)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1290607413.12457.44.camel@concordia>
References: <1290607413.12457.44.camel@concordia>
From: Timur Tabi <timur@freescale.com>
Date: Wed, 24 Nov 2010 09:44:52 -0600
Message-ID: <AANLkTikiTdw1rTxO-wxmutm=vvcxGdTKKCs_roEA7uE-@mail.gmail.com>
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
To: michael@ellerman.id.au
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips <linux-mips@linux-mips.org>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 24, 2010 at 8:03 AM, Michael Ellerman
<michael@ellerman.id.au> wrote:

> Personally I'm a bit ambivalent about it, the OF name is a bit wrong so
> it would be nice to get rid of, but it's a lot of churn.
>
> So I'm hoping people with either say "YES this is a great idea", or "NO
> this is stupid".

Well, my vote is "no".  I wouldn't call it stupid, but I do think it's
a bad idea.

In general, I don't like renaming functions, because it causes
complications with merges and porting code across kernel versions.  It
also forces me to re-remember things.

And especially in this case, the churn is too great.  You're affecting
files across multiple subsystems and architectures.

-- 
Timur Tabi
Linux kernel developer at Freescale
