Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C20EDDE0C
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 11:46:46 +1000 (EST)
Subject: Re: [PATCH] add correct interrupt property for pegasos ide
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20070404181138.GA6050@aepfle.de>
References: <20070404111635.GA1855@aepfle.de> <20070404162004.GA3016@aepfle.de>
	<200704042010.50088.bzolnier@gmail.com>
	<20070404181138.GA6050@aepfle.de>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 11:46:29 +1000
Message-Id: <1175737590.30879.105.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackeras <paulus@samba.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-04-04 at 20:11 +0200, Olaf Hering wrote:
> On Wed, Apr 04, Bartlomiej Zolnierkiewicz wrote:
> 
> > ?
> 
> You are right, I did not test the ide driver again. pata_via works with
> the change. 

Probably only the first channel works...

Ben.
