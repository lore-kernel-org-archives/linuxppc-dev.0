Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18109.2103.507694.281225@cargo.ozlabs.ibm.com>
Date: Sat, 11 Aug 2007 10:52:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: DTC 1.0.0 Release Coming?
In-Reply-To: <20070810025944.GI17370@localhost.localdomain>
References: <E1IDjSy-0003eC-T4@jdl.com>
	<20070726030550.GA1149@localhost.localdomain>
	<E1IE314-0000qF-5x@jdl.com>
	<20070726142739.GB18684@localhost.localdomain>
	<E1IE59h-0001tt-JE@jdl.com>
	<20070727013331.GB1561@localhost.localdomain>
	<20070806084813.5432ba91@weaponx.rchland.ibm.com>
	<20070810013001.GF17370@localhost.localdomain>
	<20070809203754.2e9192c5@zod.rchland.ibm.com>
	<20070810025944.GI17370@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson writes:

> We decided that since a formal dtc release was imminent, it would be
> simpler to make dtc a new kernel build requirement, rather than
> integrate the substantial blob of dtc code into the kernel tree and
> then have to deal with the maintenance / synchronization issues
> between the in-kernel and upstream versions.

Um, what I thought we decided was to ship a pre-built .dtb for ps3
(once its dts settles down), and make dtc a kernel build requirement
only for embedded platforms.

Paul.
