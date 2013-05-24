Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 5CF4F2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 May 2013 03:57:14 +1000 (EST)
Date: Fri, 24 May 2013 10:57:11 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 1/2] serial/mpc52xx_uart: prepare for adding MPC5125
 PSC UART support
Message-ID: <20130524175711.GA2712@kroah.com>
References: <1363801314-16967-3-git-send-email-matteo.facchinetti@sirius-es.it>
 <1366233702-20689-1-git-send-email-agust@denx.de>
 <20130524194912.078467c2@crub>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130524194912.078467c2@crub>
Cc: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>,
 linuxppc-dev@lists.ozlabs.org, Vladimir Ermakov <vooon341@gmail.com>,
 linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 24, 2013 at 07:49:12PM +0200, Anatolij Gustschin wrote:
> On Wed, 17 Apr 2013 23:21:41 +0200
> Anatolij Gustschin <agust@denx.de> wrote:
> 
> > From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
> > 
> > MPC5125 PSC controller has different register layout than MPC5121.
> > To support MPC5125 PSC in this driver we have to provide further
> > psc_ops functions for SoC specific register accesses.
> > 
> > Add new register access functions to the psc_ops structure and
> > provide MPC52xx and MPC512x specific implementation for them.
> > Then replace remaining direct register accesses in the driver by
> > appropriate psc_ops function calls. The subsequent patch can now
> > add MPC5125 specific set of psc_ops functions.
> > 
> > Signed-off-by: Vladimir Ermakov <vooon341@gmail.com>
> > Signed-off-by: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> > ---
> > 
> > Greg, with your Acked-by I can push these patches to my mpc5xxx tree.
> > But it is fine with me if you prefer to apply them to tty tree.
> 
> ping ...

Sorry, I somehow lost this, so I can't see the original patch at all.
Care to resend it?

thanks,

greg k-h
