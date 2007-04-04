Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B42E7DDF0D
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 04:11:19 +1000 (EST)
Date: Wed, 4 Apr 2007 20:11:38 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] add correct interrupt property for pegasos ide
Message-ID: <20070404181138.GA6050@aepfle.de>
References: <20070404111635.GA1855@aepfle.de> <20070404162004.GA3016@aepfle.de>
	<200704042010.50088.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200704042010.50088.bzolnier@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackeras <paulus@samba.org>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 04, Bartlomiej Zolnierkiewicz wrote:

> ?

You are right, I did not test the ide driver again. pata_via works with
the change. 
I will test the ide driver tomorrow.
