Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AB866DDE1B
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 00:51:26 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l6UEpKHN097816
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 14:51:20 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.4) with
	ESMTP id l6UEpKME3088532
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 15:51:20 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l6UEp6ie002443
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 15:51:07 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 2/5] ehca: Generate event when SRQ limit reached
Date: Mon, 30 Jul 2007 17:02:59 +0200
References: <200707201602.19142.hnguyen@linux.vnet.ibm.com>
	<ada7iou75tn.fsf@cisco.com>
In-Reply-To: <ada7iou75tn.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707301703.00111.hnguyen@linux.vnet.ibm.com>
Cc: fenkes@de.ibm.com, linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
> BTW, does your SRQ-capable hardware support generating the "last WQE
> reached" event?  There's not any reliable way to avoid problems when
> destroying QPs attached to an SRQ without it, and the IB spec requires
> CAs that support SRQs to generate it (o11-5.2.5 in chapter 11 of vol 1).
> 
> I don't see any code in ehca to generate the event, and IPoIB CM at
> least will be very unhappy when using SRQs if the event is not
> generated.
Thanks for this good catch. We're investigating how to implement this.
Will keep you updated.
Regards
Nam
