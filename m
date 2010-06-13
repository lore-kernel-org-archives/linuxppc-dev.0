Return-Path: <flar@cynthia.pants.nu>
Received: from cynthia.pants.nu (cynthia.allandria.com [76.245.85.235])
	by ozlabs.org (Postfix) with ESMTP id 6C484B7DAA
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jun 2010 17:10:50 +1000 (EST)
Date: Sat, 12 Jun 2010 23:37:16 -0700
From: Brad Boyer <flar@allandria.com>
To: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Anyone using "PowerPC" little-endian mode?
Message-ID: <20100613063716.GA8026@cynthia.pants.nu>
References: <20100603122012.GA22799@brick.ozlabs.ibm.com>
	<4C079F1D.7000707@mlbassoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C079F1D.7000707@mlbassoc.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 03, 2010 at 06:25:01AM -0600, Gary Thomas wrote:
> I don't know about today, but my recollection is that the only
> use of little-endian mode on PowerPC was during the early days
> attempt to run Windows-NT.

You could potentially hit this case by running Mac on Linux. A handful
of Mac programs (like early versions of VirtualPC) used this mode. Any
that did had to get fixed to run on a PowerMac G5, obviously. I haven't
personally tried this, and I wouldn't be shocked to find that MoL
chokes on this case for some other reason.

I do know that VirtualPC did this because it was G3/G4 only for a while
until they rewrote it to not use the little-endian mode.

	Brad Boyer
	flar@allandria.com
