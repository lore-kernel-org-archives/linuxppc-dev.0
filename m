Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate5.uk.ibm.com (mtagate5.uk.ibm.com [195.212.29.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4FFE4DDE25
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 02:25:26 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate5.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l1FFPM7l353580
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 15:25:22 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1FFPMb11433786
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 15:25:22 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1FFPLB5004344
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 15:25:22 GMT
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 2.6.21-rc1 1/5] ehca: reworked irq handler to avoid/reduce
	missed irq events
Date: Thu, 15 Feb 2007 16:28:35 +0100
References: <200702141740.48286.hnguyen@linux.vnet.ibm.com>
	<adafy981jgc.fsf@cisco.com>
In-Reply-To: <adafy981jgc.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702151628.35483.hnguyen@linux.vnet.ibm.com>
Cc: heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
	openib-general@openib.org, hch@infradead.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Looks fine but this patch at least has serious whitespace
> damage... please resend a fixed version.
Sorry for this. Resending the patches 1-5.

Nam
