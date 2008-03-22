Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id B3AD2DDFE1
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Mar 2008 02:54:45 +1100 (EST)
Date: Sat, 22 Mar 2008 16:25:28 +0100
From: Sven Luther <sven@genesi-usa.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: crash in init_ipic_sysfs on efika
Message-ID: <20080322152528.GA6272@powerlinux.fr>
References: <20080317195305.GA13298@aepfle.de>
	<fa686aa40803202214k7d8596a5y922a34f33d33dca2@mail.gmail.com>
	<18403.31214.826941.838442@cargo.ozlabs.ibm.com>
	<47E3B4AF.3030505@genesi-usa.com>
	<fa686aa40803211151w688a8d61sba9d0d0e6cdc7833@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40803211151w688a8d61sba9d0d0e6cdc7833@mail.gmail.com>
Cc: Olaf Hering <olaf@aepfle.de>, sven@genesi-usa.com,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 21, 2008 at 12:51:46PM -0600, Grant Likely wrote:
> On Fri, Mar 21, 2008 at 7:14 AM, Matt Sealey <matt@genesi-usa.com> wrote:
> > Is the MPC5200B PSC-AC97 driver in there?
> 
> Audio drivers need to go in via one of the ALSA developers and I
> haven't been paying close enough attention to know if it has not in
> yet.

BTW, it was reported to me that the ethernet drivers don't get
autoloaded by udev. Is this a failure of udev missing the of_plateform
support, or a deficiency of the ethernet drivers ? 

Friendly,

Sven Luther
