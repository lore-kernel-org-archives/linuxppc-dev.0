Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1CFA9DE0D2
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 13:28:59 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB52SuBr014202
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 21:28:56 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB52SuHs088198
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 19:28:56 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB52StPP005716
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 19:28:56 -0700
Date: Tue, 4 Dec 2007 20:26:25 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Merge dtc
Message-ID: <20071204202625.05367103@zod.rchland.ibm.com>
In-Reply-To: <18262.2934.447856.686438@cargo.ozlabs.ibm.com>
References: <20071016050217.GA9052@localhost.localdomain>
	<1196733544.13978.201.camel@pmac.infradead.org>
	<18261.53985.700234.923526@cargo.ozlabs.ibm.com>
	<20071204163409.6d03c7a5@zod.rchland.ibm.com>
	<18262.2934.447856.686438@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Gibson <david@gibson.dropbear.id.au>,
	David Woodhouse <dwmw2@infradead.org>, David
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 5 Dec 2007 13:22:46 +1100
Paul Mackerras <paulus@samba.org> wrote:

> Josh Boyer writes:
> 
> > Using that same reasoning, should we merge a mkimage patch for the
> > boards that use U-Boot?
> 
> I think so.  It's fairly small and it would mean that people could
> cross-compile all the defconfigs easily.

I'll try to work up a patch tonight.

josh
