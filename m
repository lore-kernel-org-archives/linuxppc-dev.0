Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with ESMTP id 26DABDE1BF
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 06:46:40 +1000 (EST)
Date: Tue, 29 Apr 2008 13:46:26 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Remi Machet <rmachet@slac.stanford.edu>
Message-ID: <20080429204626.GA8320@farnsworth.org>
References: <1209500798.14407.32.camel@pcds-ts102.slac.stanford.edu>
MIME-Version: 1.0
In-Reply-To: <1209500798.14407.32.camel@pcds-ts102.slac.stanford.edu>
Subject: Re: [PATCH v3] sysdev,mv64x60: MV64x60 device bus
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 29, 2008 at 01:26:38PM -0700, Remi Machet wrote:
> Follow up of my email of 4/16/2008 titled "MV64x60 device bus".
> For each mv64360 entry in the OpenFirmware database, add the 
> registration of an of_bus to take care of devices connected to
> the MV64x60 asynchronous devices controller.
> 
> Signed-off-by: Remi Machet (rmachet@slac.stanford.edu)

Acked-by: Dale Farnsworth <dale@farnsworth.org>
