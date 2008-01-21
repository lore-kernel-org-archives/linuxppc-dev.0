Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 801A9DDE34
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 07:34:38 +1100 (EST)
Date: Mon, 21 Jan 2008 21:34:59 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] autodetect serial console on efika
Message-ID: <20080121203459.GA9967@aepfle.de>
References: <20070331150823.GA25421@aepfle.de>
	<20080121152900.GA8664@aepfle.de>
	<fa686aa40801211045w7644cfc5tf11024bd0010b308@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <fa686aa40801211045w7644cfc5tf11024bd0010b308@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 21, Grant Likely wrote:

> On 1/21/08, Olaf Hering <olaf@aepfle.de> wrote:
> >
> > Efika boards have to be booted with console=ttyPSC0 unless there is a
> > graphics card plugged in. Detect if the firmware stdout is the serial
> > connector.
> >
> > Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> Hrrrum; I think this is a good idea, but I'm not thrilled with the
> approach.  Here are my concerns:
> 
> - Determining that linux,stdout-path points to a PSC should should be
> done in common code.  It's useful for all 5200 boards, not just the
> Efika.  (However, if 'failsafe' processing is efika specific, then it
> can stay in efika.c).  This might be best done within the PSC driver
> itself, but I'm not sure.
> - Recognizing a psc node should be done by inspecting the compatible
> property, not by device_type and model properties.

I dont have any other 5200 hardware to test a different patch.
Please improve my version and submit it for inclusion.
