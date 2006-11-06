Return-Path: <HNGUYEN@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F06BB67D55
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 21:36:26 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id kA6AaHUg215568
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 10:36:17 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kA6AdJRs3022998
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 11:39:19 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kA6AaDf4024564
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 11:36:14 +0100
In-Reply-To: <200611060045.59074.arnd@arndb.de>
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control
	block in 64k page mode
To: rolandd@cisco.com
Message-ID: <OF69697CF5.13DC8781-ONC125721E.0039CD42-C125721E.003A3D50@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Mon, 6 Nov 2006 11:39:09 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Christoph Raisch <raisch@de.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Roland!
> Arnd wrote:
> This seems broken. You have a constructor for newly allocated objects,
but
> there is no destructor and it seems that objects passed to
> ehca_free_fw_ctrlblock are not guaranteed to be initialized either.
> I'd simply move the memset into the alloc function and get rid of the
> constructor here.
As Arnd stated I need to fix this ctor issue. Do you prefer me to resend
all patches in proper format (non-mangled inline) or just this one bug fix?
Thanks!
Nam
