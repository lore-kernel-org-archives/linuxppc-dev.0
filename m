Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D44667CBD
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Nov 2006 07:44:45 +1100 (EST)
Subject: Re: [PATCH] powerpc: Make alignment exception always check
	exception table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20061101063401.GA25664@kroah.com>
References: <1162350571.25682.389.camel@localhost.localdomain>
	<20061101063401.GA25664@kroah.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 07:43:15 +1100
Message-Id: <1162413796.25682.414.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-10-31 at 22:34 -0800, Greg KH wrote:
> On Wed, Nov 01, 2006 at 02:09:30PM +1100, Benjamin Herrenschmidt wrote:
> > The alignment exception used to only check the exception table for
> > -EFAULT, not for other errors. That opens an oops window if we can
> > coerce the kernel into getting an alignment exception for other reasons
> > in what would normally be a user-protected accessor, which can be done
> > via some of the futex ops. This fixes it by always checking the
> > exception tables.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > 
> > This is 2.6.19 material and should probably go into stable as well.
> > (Greg: take it if paulus acks it and it applies :)
> 
> Please forward the final patch (which ever version it is :) to the
> stable@kernel.org address when this goes into mainline.

Ok, will do. I wan't sure what the proper procedure was.

Cheers,
Ben.
