Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (unknown [209.180.55.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2FBF5DDFEB
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 07:12:20 +1000 (EST)
Date: Wed, 5 Sep 2007 16:12:13 -0500
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 04/10] bootwrapper: Add strtoull().
Message-ID: <20070905161213.091c00cc@vader.jdub.homelinux.org>
In-Reply-To: <20070905192110.GD32113@ld0162-tx32.am.freescale.net>
References: <20070905192001.GA32049@ld0162-tx32.am.freescale.net>
	<20070905192110.GD32113@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 5 Sep 2007 14:21:10 -0500
Scott Wood <scottwood@freescale.com> wrote:

> This will be needed by PlanetCore firmware support.

Bamboo would like to use this too.  And probably anything else that has
PIBS as a bootloader.  I could forsee Holly using this too.

josh
