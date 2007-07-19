Return-Path: <cornelia.huck@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B95DADDE2A
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 22:52:13 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l6JCq87H320400
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 12:52:08 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6JCq8Xp2158808
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 14:52:08 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6JCq2oY001704
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 14:52:02 +0200
Date: Thu, 19 Jul 2007 14:52:33 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 1/3] ps3: Disk Storage Driver
Message-ID: <20070719145233.6c66e584@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <Pine.LNX.4.62.0707191411060.8661@pademelon.sonytel.be>
References: <20070716161539.075822000@pademelon.sonytel.be>
	<20070716162206.392129000@pademelon.sonytel.be>
	<20070718163637.3f0e0164.akpm@linux-foundation.org>
	<Pine.LNX.4.62.0707191039430.8661@pademelon.sonytel.be>
	<20070719112602.5e3cb21a@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.62.0707191132150.8661@pademelon.sonytel.be>
	<20070719140038.606abd44@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.62.0707191411060.8661@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	Jens Axboe <jens.axboe@oracle.com>, linux-scsi@vger.kernel.org,
	Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Linux,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 19 Jul 2007 14:13:33 +0200 (CEST),
Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

> Any chance this will change? I already added a mutex to ps3disk to protect
> against this.

Probably not in the near future. A mutex looks like a good idea though,
since one never knows (and the driver core generally doesn't make many
guarantees regarding serialization).
