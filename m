Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 001/001] PMAC HD runtime blinking control
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cedric Pradalier <cedric.pradalier@free.fr>
In-Reply-To: <20060122121907.792abc72.cedric.pradalier@free.fr>
References: <20060122121907.792abc72.cedric.pradalier@free.fr>
Content-Type: text/plain
Date: Sun, 22 Jan 2006 13:49:53 +1100
Message-Id: <1137898193.12998.83.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-01-22 at 12:19 +1000, Cedric Pradalier wrote:
> Hi,
> 
> I've finally spend the time to mend the patch for control of
> the HD led blinking at runtime. This is a patch against
> 2.6.15
> 
> The sysfs entry is attached to the PCI device and to the
> MACIO device if available. I think that was what Ben was
> asking for:

Heh, nice :) Almost ! It would be better if it was attached to the sysfs
node of the ide interface, you can find it in the HWIF array after
probe, but I won't be too much of a pain about that for now :)

Ben.
