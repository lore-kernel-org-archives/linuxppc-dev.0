Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A8304DDE3A
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 22:54:22 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2PBqmH5025951
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 07:52:48 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2PBsG3w191174
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 05:54:16 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2PBsFwl002455
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 05:54:16 -0600
Date: Tue, 25 Mar 2008 06:51:58 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [RESEND] [PATCH 1/2 v2] [OF] Add of_device_is_available function
Message-ID: <20080325065158.6c299e05@zod.rchland.ibm.com>
In-Reply-To: <20080325004753.5885ede9@lappy.seanm.ca>
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
	<20080301174825.57715d46@zod.rchland.ibm.com>
	<18407.37606.990271.551578@cargo.ozlabs.ibm.com>
	<20080325004753.5885ede9@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 25 Mar 2008 00:47:53 -0400
Sean MacLennan <smaclennan@pikatech.com> wrote:

> On Mon, 24 Mar 2008 22:39:18 +1100
> "Paul Mackerras" <paulus@samba.org> wrote:
> 
> > The second test will succeed for anything that starts with "ok", so
> > the first test is redundant.  I suspect you want strcmp instead of
> > strncmp in both tests.
> 
> I like the strncmp(status, "ok", 2). Then you can have a status of
> okey-dokey ;)

You can also have "oklahoma", "okaly-dokaly-do" (I hate Ned Flanders),
and "ok-this-device-is-fubar-don't-ever-touch-it!"

We really want just "okay" and "ok".  Look for a version 3 of the patch
that fixes it later today.

josh
