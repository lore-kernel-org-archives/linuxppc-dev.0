Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E59ED67BDD
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 07:39:51 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAGKdmBV005370
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 15:39:48 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAGKdmM8336080
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 13:39:48 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAGKdltX018275
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 13:39:48 -0700
Date: Thu, 16 Nov 2006 14:39:46 -0600
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH]: HVCS char driver janitoring: fix compile warnings
Message-ID: <20061116203946.GA23600@austin.ibm.com>
References: <20061115212619.GJ8395@austin.ibm.com>
	<1163635387.8805.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1163635387.8805.7.camel@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Alan Cox <alan@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 16, 2006 at 11:03:07AM +1100, Michael Ellerman wrote:
> On Wed, 2006-11-15 at 15:26 -0600, Linas Vepstas wrote:
> > 
> > This is a non-urgent patch. 
> > 
> > I can't figure out who the upstream maintainer for char drivers 
> > is supposed to be. Can this patch be applied? 
> > 
> > --linas
> > 
> > This patch removes an pair of irritating compiler warnings:
> > 
> > drivers/char/hvcs.c:1605: warning: ignoring return value of
> > sysfs_create_group declared with attribute warn_unused_result
> > drivers/char/hvcs.c:1639: warning: ignoring return value of
> > driver_create_file declared with attribute warn_unused_result
> > 
> > Doing this required moving a big block of code from the bottom 
> > of the file to the top, so as to avoid the need for (irritating) 
> > forward declarations.
> 
> Can you do the move and the fix as two patches? It's very hard to review
> in its current form.

Sorry, coming shortly. -- linas
