Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D22C9DE02D
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 02:57:08 +1100 (EST)
Date: Tue, 14 Oct 2008 19:57:44 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
	[take 2]
Message-ID: <20081014195744.23a1a3e4@vitb-lp>
In-Reply-To: <Pine.LNX.4.44L0.0810141059300.2546-100000@iolanthe.rowland.org>
References: <20081014142512.2ebdde4c@vitb-lp>
	<Pine.LNX.4.44L0.0810141059300.2546-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Have you tried building this on a non-PPC440EPx system?  It looks
> like this patch would cause a compile error.
yes, correct, last minute fix didn't make it into the patch, sorry
about that.

Will refresh, test and resubmit.

-Vitaly
