Date: Wed, 18 Jun 2003 09:32:18 -0500
From: Chris Zimman <chris@cryptoapps.com>
To: Christophe.LINDHEIMER@fr.thalesgroup.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Linux][MTD] Is it possible to use MTD without CFI ?
Message-ID: <20030618143218.GB9894@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <D96E2AFA0DF3D211B13900902745494803736331@helios.gnv.tcc.thomson-csf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D96E2AFA0DF3D211B13900902745494803736331@helios.gnv.tcc.thomson-csf.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 18, 2003 at 03:13:11PM +0200, Christophe.LINDHEIMER@fr.thalesgroup.com wrote:
> I would like to use MTD to put my romfs but without using CFI.
> I am using XIP and I can't accept the flash to go into strange config
> state...
> So I thought about selecting MTD & "Driver for non CFI Flash".
> But I don't undersatnd where I can give the @ of my flash...
> In fact the menu where to go give the @ only appears when selecting CFI...

That depends upon what kind flash you're using.  If your flash supports
JEDEC support, then you can use that method for accessing.

Look in drivers/mtd/maps for some example setup routines.

--Chris
~

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
