Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id B79AEDDDF3
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 09:34:03 +1100 (EST)
Date: Mon, 12 Mar 2007 15:34:25 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 00/19] bootwrapper/cuImage patches
Message-ID: <20070312223425.GD31268@mag.az.mvista.com>
References: <20070312204102.GA28478@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070312204102.GA28478@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 02:41:02PM -0600, Scott Wood wrote:
> I've rebased the bootwrapper changes onto David Gibson's March 5th
> bootwrapper patches 6, 7, and 8 (zImage: Add more flexible gunzip
> convenience functions, zImage: Cleanup and improve prep_kernel(), and
> zImage: Cleanup and improve zImage entry point).
> 
> I've also addressed some concerns that were raised since the last
> patchset I posted.
> 
> I've tested it on an MPC8313 and a G4 PowerMac.  I've tested it with a
> VPATH, and the dtb is correctly created in the output directory.
> 
> Paul, please apply the above prerequisite patches and this patchset for
> 2.6.22 if there are no objections this time.

FWIW, I'm ack'ing the patches that touch files I've been fairly involved
with.

Mark
