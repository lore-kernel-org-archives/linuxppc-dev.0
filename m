Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17748.27504.715056.565983@cargo.ozlabs.ibm.com>
Date: Fri, 10 Nov 2006 23:07:12 +1100
From: Paul Mackerras <paulus@samba.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: ipr SATA support is causing problems
In-Reply-To: <1163159326.19697.23.camel@crusty.rchland.ibm.com>
References: <17748.25705.543922.486456@cargo.ozlabs.ibm.com>
	<1163159326.19697.23.camel@crusty.rchland.ibm.com>
Cc: akpm@osdl.org, James Bottomley <jejb@mulgrave.il.steeleye.com>,
	linuxppc-dev@ozlabs.org, torvalds@osdl.org, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer writes:

> John Rose reported this a few days ago.  Brian responded with this:
> 
> http://marc.theaimsgroup.com/?l=linux-ide&m=116169938407596&w=2

Didn't John say he still saw the crash with that change?

Anyway, my point would be that either that patch (assuming it fixes
the problem) needs to go in 2.6.19, or 35a39691e4 needs to be
reverted.

Jeff, any comments on Brian's patch?

Paul.
