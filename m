Return-Path: <stern+5260885c@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by ozlabs.org (Postfix) with SMTP id C757E2C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2013 02:04:33 +1100 (EST)
Date: Thu, 7 Nov 2013 10:04:31 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH 4/7] IBM Akebono: Add support to the OHCI platform driver
 for Akebono
In-Reply-To: <1462812.9fJW2bi87G@mexican>
Message-ID: <Pine.LNX.4.44L0.1311071003350.1401-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 7 Nov 2013, Alistair Popple wrote:

> Thanks. Based on the discussion for the EHCI driver I would like to change the 
> compatibility string to "usb-ochi" (instead of "ibm,akebono-ohci"). Are you 
> still happy for me to add the Acked-by with the alternate compatibility (and 
> of course the formatting fix)? No other drivers currently use "usb-ochi" so it 
> shouldn't require any merging of drivers.

Yes, go ahead (as long as you use the right spelling, as Ben pointed 
out).

Alan Stern
