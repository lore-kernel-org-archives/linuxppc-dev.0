Return-Path: <dave@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2BCF6DE66E
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 04:12:42 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9DHCco6001283
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 13:12:38 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9DHCc7n272442
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 13:12:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9DHCcWV030606
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 13:12:38 -0400
Subject: Re: [PATCH]IB/ehca:reject dynamic memory add/remove
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
In-Reply-To: <200810131310.34413.ossrosch@linux.vnet.ibm.com>
References: <200810131310.34413.ossrosch@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Mon, 13 Oct 2008 10:09:26 -0700
Message-Id: <1223917766.29877.17.camel@nimitz>
Mime-Version: 1.0
Cc: LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
	general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-10-13 at 13:10 +0200, Stefan Roscher wrote:
> Since the ehca device driver does not support dynamic memory add and remove
> operations, the driver must explicitly reject such requests in order to prevent
> unpredictable behaviors related to memory regions already occupied and being
> used by InfiniBand applications.
> The solution is to add a memory notifier to the ehca device driver and if a request
> for dynamic memory add or remove comes in, ehca will always reject it.

Why doesn't the driver support it?

This seems like an awfully extreme action to take.  Do you have plans to
support this in the driver soon?

-- Dave
