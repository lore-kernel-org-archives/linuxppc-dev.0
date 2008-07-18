Return-Path: <glikely@secretlab.ca>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.188])
	by ozlabs.org (Postfix) with ESMTP id 984DBDE6AF
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 02:14:18 +1000 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so166530rnf.16
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 09:14:16 -0700 (PDT)
Date: Fri, 18 Jul 2008 10:14:13 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, timur@freescale.com
Subject: Re: [alsa-devel] [PATCH 3/3] ALSA SoC: Add Texas Instruments
	TLV320AIC26 codec driver
Message-ID: <20080718161413.GA10317@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235340.16923.48024.stgit@trillian.secretlab.ca>
	<1214995713.4882.54.camel@localhost.localdomain>
	<20080712060018.GB23213@secretlab.ca>
	<20080712173609.GA6523@sirena.org.uk>
	<20080717233153.GA8187@secretlab.ca>
	<20080718095823.GA14416@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080718095823.GA14416@sirena.org.uk>
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 18, 2008 at 10:58:25AM +0100, Mark Brown wrote:
> Sparse (or sparsely used) register maps are pretty common - in practice
> it's not been a problem to just have a cache that covers everything and
> only gets read, the amount of data involved is rarely that large in the
> context of what you need to store the audio you're working with.

okay.

g.
