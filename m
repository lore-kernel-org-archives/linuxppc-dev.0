Return-Path: <bzolnier@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.184])
	by ozlabs.org (Postfix) with ESMTP id C3681DDE05
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 20:56:32 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id e30so1023425fke.9
	for <linuxppc-dev@ozlabs.org>; Fri, 01 Aug 2008 03:56:30 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: ide pmac breakage
Date: Fri, 1 Aug 2008 12:54:02 +0200
References: <1217208596.11188.144.camel@pasglop>
	<1217478322.11188.410.camel@pasglop>
	<200807311251.02251.bzolnier@gmail.com>
In-Reply-To: <200807311251.02251.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808011254.02989.bzolnier@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org,
	petkovbb@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thursday 31 July 2008, Bartlomiej Zolnierkiewicz wrote:

[...]

Sorry if my mails were a bit harsh but nobody likes to be pushed around.

[ It is not like I don't want to add proper hot-plugging support or do test
  on more hardware but my time schedule is already tight enough and there are
  still more fundamental things to address (which take priority). ]

> -                host->dev[0] = hws[0]->dev;
> +                host->dev[0] = hws[0]->parent ? hws[0]->parent : hws[0]->dev;
> 
> Could you please try it together with my previous patch for
> ide_device_{get,put}()?

Please test it when you have some time.
