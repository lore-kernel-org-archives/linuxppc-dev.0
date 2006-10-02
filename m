Return-Path: <HNGUYEN@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E0C6A67BE6
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 06:27:16 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id k92KRAOH083170
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 20:27:10 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k92KTHUl1495272
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 22:29:17 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k92KRAnp021663
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Oct 2006 22:27:10 +0200
In-Reply-To: <adamz8ews9m.fsf@cisco.com>
Subject: Re: [PATCH 2.6.19-rc1] ehca: fix ehca_probe if module loaded after
	ib_ipoib
To: Roland Dreier <rdreier@cisco.com>
Message-ID: <OF2EAA258C.4C5B6298-ONC12571FB.0070557F-C12571FB.00706BF1@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Mon, 2 Oct 2006 22:29:16 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	openib-general@openib.org, openfabrics-ewg@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Looks OK but your mailer mangled the patch.  Please resend in a form
> that can be applied...
> please send unrelated changes as separate patches.
> So this should come as two patches -- one to fix the device
> registration, and one to change your debug formatting.
ok, will resend those two patches soon.
