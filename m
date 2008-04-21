Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 26171DE364
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 04:56:54 +1000 (EST)
Date: Mon, 21 Apr 2008 11:56:41 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Remi Machet <rmachet@slac.stanford.edu>
Message-ID: <20080421185641.GA14647@farnsworth.org>
References: <1208803572.5789.78.camel@pcds-ts102.slac.stanford.edu>
MIME-Version: 1.0
In-Reply-To: <1208803572.5789.78.camel@pcds-ts102.slac.stanford.edu>
Subject: Re: [PATCH 2/2 v3] sysdev,mv64x60: initialization of mv64x60
	ethernet, serial and I2C
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 11:46:12AM -0700, Remi Machet wrote:
> If one of the devices of the mv64x60 init fails, the remaining 
> devices are not initialized => This patch changes the code to 
> display an error and continue the initialization.
> 
> Signed-off-by: Remi Machet (rmachet@slac.stanford.edu)

Acked by: Dale Farnsworth <dale@farnsworth.org>
