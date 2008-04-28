Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with ESMTP id CA248DDF8D
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 04:10:02 +1000 (EST)
Date: Mon, 28 Apr 2008 11:09:47 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Remi Machet <rmachet@slac.stanford.edu>
Message-ID: <20080428180947.GA2691@farnsworth.org>
References: <1209402729.14407.2.camel@pcds-ts102.slac.stanford.edu>
MIME-Version: 1.0
In-Reply-To: <1209402729.14407.2.camel@pcds-ts102.slac.stanford.edu>
Subject: Re: [PATCH] sysdev,mv64x60: MV64x60 device bus
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

On Mon, Apr 28, 2008 at 10:12:09AM -0700, Remi Machet wrote:
> Follow up of my email of 4/16/2008 titled "MV64x60 device bus".
> For each mv64360 entry in the OpenFirmware database, add the 
> registration of an of_bus to take care of devices connected to
> the MV64x60 asynchronous devices controller.

I'd like to see your dts file to see exactly how you're using it.

The only problem I see now is that you have introduced a new device
type, "devicectrl".  New device types are frowned upon.  It's better
to match based on the compatible field.  Maybe use
"marvell,mv64306-devctrl" or similar.

-Dale
