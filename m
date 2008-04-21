Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A614DEDC5
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 07:32:18 +1000 (EST)
Date: Mon, 21 Apr 2008 14:32:10 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Remi Machet <rmachet@slac.stanford.edu>
Message-ID: <20080421213210.GA21645@farnsworth.org>
References: <1208811777.5789.86.camel@pcds-ts102.slac.stanford.edu>
MIME-Version: 1.0
In-Reply-To: <1208811777.5789.86.camel@pcds-ts102.slac.stanford.edu>
Subject: Re: [PATCH] sysdev,mv64x60: early console fix
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

On Mon, Apr 21, 2008 at 02:02:56PM -0700, Remi Machet wrote:
> The MPSC driver and prpmc2800.dts have been modified to
> use property 'cell-index' as the serial port number but 
> the early serial console driver for the mv64x60 has not 
> been modified to use this new property.
> 
> Signed-off-by: Remi Machet (rmachet@slac.stanford.edu)

Acked-by: Dale Farnsworth <dale@farnsworth.org>
