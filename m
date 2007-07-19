Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CD346DDED7
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 02:42:05 +1000 (EST)
Date: Thu, 19 Jul 2007 09:26:25 -0700
From: Greg KH <gregkh@suse.de>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/2] 2.6.22-git: known regressions
Message-ID: <20070719162625.GA16505@suse.de>
References: <469F9125.8040502@googlemail.com> <469F92AF.10405@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <469F92AF.10405@googlemail.com>
Cc: Andi Kleen <ak@suse.de>, Theodore Tso <tytso@mit.edu>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>, Doug Chapman <doug.chapman@hp.com>,
	Vasily Tarasov <vtaras@openvz.org>, linux-ide@vger.kernel.org,
	Tejun Heo <htejun@gmail.com>, Mingming Cao <cmm@us.ibm.com>,
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Jean Delvare <khali@linux-fr.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 19, 2007 at 06:34:55PM +0200, Michal Piotrowski wrote:
> SYSFS
> 
> Subject         : sysfs root link count broken in 2.6.22-git5
> References      : http://lkml.org/lkml/2007/7/15/62
> Last known good : ?
> Submitter       : Jean Delvare <khali@linux-fr.org>
> Caused-By       : ?
> Handled-By      : Tejun Heo <htejun@gmail.com>
> Status          : unknown

This is now fixed in Linus's tree with a patch from Tejun.

thanks,

greg k-h
