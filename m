Return-Path: <satyam.sharma@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by ozlabs.org (Postfix) with ESMTP id 12E97DDEFB
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 03:07:18 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id i23so492126wra
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 10:07:17 -0700 (PDT)
Message-ID: <a781481a0707191007q241f5f5bh6c029da56090d8b3@mail.gmail.com>
Date: Thu, 19 Jul 2007 22:37:15 +0530
From: "Satyam Sharma" <satyam.sharma@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/2] 2.6.22-git: known regressions
In-Reply-To: <469F92AF.10405@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <469F9125.8040502@googlemail.com> <469F92AF.10405@googlemail.com>
Cc: Andi Kleen <ak@suse.de>, Theodore Tso <tytso@mit.edu>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
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

> Subject         : ext4 build warnings
> References      : http://lkml.org/lkml/2007/7/18/420
> Last known good : ?
> Submitter       : Jeff Garzik <jeff@garzik.org>
> Caused-By       : ?
> Handled-By      : Mingming Cao <cmm@us.ibm.com>
> Status          : unknown

Mingming Cao fixed this:

http://lkml.org/lkml/2007/7/18/564

Dunno if it's in latest git
