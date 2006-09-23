Return-Path: <HNGUYEN@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C40B567B9B
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Sep 2006 06:43:46 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.8/8.13.8) with ESMTP id k8NKhevr048502
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 20:43:40 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k8NKjXoP1892588
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 22:45:33 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k8NKhd0U023084
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 22:43:40 +0200
In-Reply-To: <adahcyzfkd0.fsf@cisco.com>
Subject: Re: [PATCH 2.6.19-rc1] ehca firmware interface based on Anton
	Blanchard's new hvcall interface
To: Roland Dreier <rdreier@cisco.com>
Message-ID: <OFFF711B0A.758C0571-ONC12571F2.0070BAD2-C12571F2.0071ED80@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Sat, 23 Sep 2006 22:45:28 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: pmac@au1.ibm.com, linux-kernel@vger.kernel.org, openib-general@openib.org,
	openfabrics-ewg@openib.org, linuxppc-dev@ozlabs.org,
	"Christoph.Raisch/Germany/IBM" <Christoph.Raisch/Germany/IBM@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Roland,
> Anyway both Paul and I merged with Linus today, so the hcall cleanup
> and ehca are both upstream.  It would be great if you could do a quick
> check to make sure that ehca works in Linus's current git tree.
I compiled Linus's git tree and did some basic tests successfully
with ehca (ipoib, userspace, netpipe tcp/ib).
Thanks!
Nam Nguyen
