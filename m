Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Migrate "one cell" checks to new framework 
In-Reply-To: Your message of "Thu, 06 Dec 2007 16:59:45 +1100."
	<20071206055945.GD19927@localhost.localdomain>
References: <20071206055945.GD19927@localhost.localdomain> 
Date: Thu, 06 Dec 2007 09:20:21 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1J0IWU-000587-0i@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> This patch converts to the new tree checking framework those checks
> which verify that certain properties (#address-cells and #size-cells)
> are exactly one cell in size, when present.
> 
> We also drop the old-style check for "linux,phandle" being one cell,
> since that is already implied in the the existing new-style checks on
> the linux,phandle property.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
