Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from mtagate8.uk.ibm.com (mtagate8.uk.ibm.com [195.212.29.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 374CADDDEF
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 20:29:06 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate8.uk.ibm.com (8.13.8/8.13.8) with ESMTP id mB39SvE0585348
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Dec 2008 09:28:57 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id mB39Su2W1687620
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Dec 2008 09:28:56 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id mB39StpA029323
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Dec 2008 09:28:56 GMT
Date: Wed, 3 Dec 2008 10:28:54 +0100
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 1/1] hvc_console: fix: hp->ws winsize check runs
	out-of-sync
Message-ID: <20081203092854.GE28137@cetus.boeblingen.de.ibm.com>
References: <20081118112827.927627788@linux.vnet.ibm.com>
	<20081118113848.945650506@linux.vnet.ibm.com>
	<18742.20121.759577.660481@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18742.20121.759577.660481@cargo.ozlabs.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

On Wed, Dec 03, 2008 at 08:17:13PM +1100, Paul Mackerras wrote:
> Looks OK.  Is this going to go in via the s390 tree, or should I put
> it in the powerpc tree?
The patch should go via the powerpc tree.

Thanks and regards,
Hendrik
