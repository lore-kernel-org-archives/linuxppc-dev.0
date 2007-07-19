Return-Path: <cmm@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 34079DDF3B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 03:21:40 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6JHLXVL032106
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 13:21:33 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6JHLXGt413684
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 13:21:33 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6JHLWgv009414
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 13:21:33 -0400
Message-ID: <469F9D92.9000708@us.ibm.com>
Date: Thu, 19 Jul 2007 10:21:22 -0700
From: Mingming Caoc <cmm@us.ibm.com>
MIME-Version: 1.0
To: Satyam Sharma <satyam.sharma@gmail.com>
Subject: Re: [2/2] 2.6.22-git: known regressions
References: <469F9125.8040502@googlemail.com> <469F92AF.10405@googlemail.com>
	<a781481a0707191007q241f5f5bh6c029da56090d8b3@mail.gmail.com>
In-Reply-To: <a781481a0707191007q241f5f5bh6c029da56090d8b3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andi Kleen <ak@suse.de>, Theodore Tso <tytso@mit.edu>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org,
	Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>,
	Doug Chapman <doug.chapman@hp.com>,
	Vasily Tarasov <vtaras@openvz.org>, linux-ide@vger.kernel.org,
	Tejun Heo <htejun@gmail.com>, linux-fsdevel@vger.kernel.org,
	Jean Delvare <khali@linux-fr.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <clameter@sgi.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Satyam Sharma wrote:
>> Subject         : ext4 build warnings
>> References      : http://lkml.org/lkml/2007/7/18/420
>> Last known good : ?
>> Submitter       : Jeff Garzik <jeff@garzik.org>
>> Caused-By       : ?
>> Handled-By      : Mingming Cao <cmm@us.ibm.com>
>> Status          : unknown
> 
> Mingming Cao fixed this:
> 
> http://lkml.org/lkml/2007/7/18/564
> 
> Dunno if it's in latest git

Andrew pushed the patch to Linus last night.

Thanks,

Mingming
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
