Date: Tue, 5 Aug 2003 15:39:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Brian Waite <waite@skycomputers.com>
Cc: Linux PPC <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pImage target gone
Message-ID: <20030805223917.GA579@ip68-0-152-218.tc.ph.cox.net>
References: <200308051748.29796.waite@skycomputers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200308051748.29796.waite@skycomputers.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 05, 2003 at 05:48:29PM -0400, Brian Waite wrote:

> 	I recently pulled the head and I found that we have lost the pImage
> BOOT_TARGET. With some quick searching I found Paulus removed back on April
> 18, 2003. The comment notes the changes were for the removal of ppc32 iSeries
> support. Now, I have boards that use the pImage target. I was wondering if,
> since it is removed now, maybe we should reincoporate it as uImage to reflect
> the new name of u-boot. Is there another reason why this might have been
> removed? Just curious. Otherwise I'll supply a patch.

A patch for both 2.4 and 2.6, that adds uImage AND make sure that the
related scripts are executable will be happily accepted.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
