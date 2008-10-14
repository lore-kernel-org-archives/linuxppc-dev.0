Return-Path: <dave@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B3669DDEF9
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 23:29:25 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id m9ECQMdQ018550
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 08:26:22 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9ECTJel222468
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 08:29:19 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9ECTJEn015829
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 08:29:19 -0400
Subject: Re: [PATCH]IB/ehca:reject dynamic memory add/remove
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Stefan Roscher <stefan.roscher@vnet.de.ibm.com>
In-Reply-To: <200810141423.48111.stefan.roscher@vnet.de.ibm.com>
References: <200810131310.34413.ossrosch@linux.vnet.ibm.com>
	<1223917766.29877.17.camel@nimitz>
	<200810141423.48111.stefan.roscher@vnet.de.ibm.com>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 05:29:13 -0700
Message-Id: <1223987353.29877.40.camel@nimitz>
Mime-Version: 1.0
Cc: LKML <linux-kernel@vger.kernel.org>,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-10-14 at 14:23 +0200, Stefan Roscher wrote:
> On Monday 13 October 2008 07:09:26 pm Dave Hansen wrote:
> > On Mon, 2008-10-13 at 13:10 +0200, Stefan Roscher wrote:
> > > Since the ehca device driver does not support dynamic memory add and remove
> > > operations, the driver must explicitly reject such requests in order to prevent
> > > unpredictable behaviors related to memory regions already occupied and being
> > > used by InfiniBand applications.
> > > The solution is to add a memory notifier to the ehca device driver and if a request
> > > for dynamic memory add or remove comes in, ehca will always reject it.
> > 
> > Why doesn't the driver support it?
> > 
> > This seems like an awfully extreme action to take.  Do you have plans to
> > support this in the driver soon?
> > 
> There is currently a slight incompatibility how openfabrics uses MRs
> and how System p does DMEM add/remove, which basically disables this
> support.
> If you want to talk to the firmware developpers, I can give you the right contacts.

I wish I knew what an 'MR' is. :(

Could you be a bit more specific so we can get a better changelog?
Perhaps if we understand the situation better, we can come up with a
better solution.

Does this have anything in common with the problems with 16GB pages?

-- Dave
