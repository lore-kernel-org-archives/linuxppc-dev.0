Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id B7CECDDE36
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 00:36:45 +1000 (EST)
Date: Mon, 21 May 2007 16:36:43 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] remove geometry support from ps3 storage driver
In-Reply-To: <20070521125311.GA27626@aepfle.de>
Message-ID: <Pine.LNX.4.62.0705211631161.31381@pademelon.sonytel.be>
References: <20070521125311.GA27626@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Hi Olaf,

On Mon, 21 May 2007, Olaf Hering wrote:
> The old ps3_storage driver did not support DOS geometry, so there is no
> point to start adding code for it.

Thanks! I didn't know the .getgeo() routine is optional. I thought it was used
by disk partitioning software.

cfdisk seems to be happy after this change.
sfdisk complains it cannot get the geometry, but it continuous, assuming H=64
and S=32.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
