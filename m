Return-Path: <bzolnier@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 2550DDDF34
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 05:11:00 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k40so495097ugc
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 12:10:59 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/2] 2.6.22-git: known regressions
Date: Thu, 19 Jul 2007 21:27:06 +0200
References: <469F9125.8040502@googlemail.com> <469F92AF.10405@googlemail.com>
In-Reply-To: <469F92AF.10405@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200707192127.07238.bzolnier@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Theodore Tso <tytso@mit.edu>,
	Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org,
	Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>,
	Doug Chapman <doug.chapman@hp.com>,
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

On Thursday 19 July 2007, Michal Piotrowski wrote:

> IDE
> 
> Subject         : compile error if CONFIG_BLOCK not enabled related to linux/ide.h include
> References      : http://lkml.org/lkml/2007/7/18/11
> Last known good : ?
> Submitter       : Kumar Gala <galak@kernel.crashing.org>
> Caused-By       : ?
> Handled-By      : Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Status          : unknown

Not a 2.6.22-git regression (CONFIG_BLOCK was added on September 2006) and
Kumar should have a fix really soon - could be removed from the list IMO.

Thanks,
Bart
