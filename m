Return-Path: <linuxppc-embedded@ml.breakpoint.cc>
Date: Fri, 12 Sep 2008 17:31:43 +0200
From: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: boot cuImage on an old u-boot
Message-ID: <20080912153143.GA19267@Chamillionaire.breakpoint.cc>
References: <20080820150958.GA23294@Chamillionaire.breakpoint.cc>
	<20080821161505.GA15669@ld0162-tx32.am.freescale.net>
	<20080825093617.GA1619@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20080825093617.GA1619@yookeroo.seuss>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* David Gibson | 2008-08-25 19:36:17 [+1000]:

>Make sure the device tree contains a linux,stdout-path property in
>/chosen.

Oh. it did the trick.
Thanks.

Sebastian
