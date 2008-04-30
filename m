Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18455.63249.595170.712335@cargo.ozlabs.ibm.com>
Date: Wed, 30 Apr 2008 14:35:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: Remi Machet <rmachet@slac.stanford.edu>
Subject: Re: [PATCH v3] sysdev,mv64x60: MV64x60 device bus
In-Reply-To: <1209500798.14407.32.camel@pcds-ts102.slac.stanford.edu>
References: <1209500798.14407.32.camel@pcds-ts102.slac.stanford.edu>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remi Machet writes:

> Follow up of my email of 4/16/2008 titled "MV64x60 device bus".
> For each mv64360 entry in the OpenFirmware database, add the 
> registration of an of_bus to take care of devices connected to
> the MV64x60 asynchronous devices controller.

Your patch description should also explain what good things will come
of doing this, or what bad things will be avoided.  Also please put
the "Follow up..." sentence below the 3 dashes so I don't have to edit
it out.

If there are no further review comments, and if you resend with a
better patch description, I'll queue this up for the next merge window
(for 2.6.27).

Paul.
