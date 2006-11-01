Return-Path: <greg@kroah.com>
Received: from perch.kroah.org (mail.kroah.org [69.55.234.183])
	by ozlabs.org (Postfix) with ESMTP id 420EB67B5F
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 18:03:57 +1100 (EST)
Date: Tue, 31 Oct 2006 22:34:01 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Make alignment exception always check exception
	table
Message-ID: <20061101063401.GA25664@kroah.com>
References: <1162350571.25682.389.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1162350571.25682.389.camel@localhost.localdomain>
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

On Wed, Nov 01, 2006 at 02:09:30PM +1100, Benjamin Herrenschmidt wrote:
> The alignment exception used to only check the exception table for
> -EFAULT, not for other errors. That opens an oops window if we can
> coerce the kernel into getting an alignment exception for other reasons
> in what would normally be a user-protected accessor, which can be done
> via some of the futex ops. This fixes it by always checking the
> exception tables.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> This is 2.6.19 material and should probably go into stable as well.
> (Greg: take it if paulus acks it and it applies :)

Please forward the final patch (which ever version it is :) to the
stable@kernel.org address when this goes into mainline.

thanks,

greg k-h
