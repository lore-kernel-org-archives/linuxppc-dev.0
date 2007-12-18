Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Remove remaining old-style checks 
In-Reply-To: Your message of "Tue, 18 Dec 2007 14:54:38 +1100."
	<20071218035438.GA10348@localhost.localdomain>
References: <20071218035438.GA10348@localhost.localdomain> 
Date: Tue, 18 Dec 2007 07:56:33 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1J4cvx-0007Rm-El@jdl.com>
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
> The remaining old-style tree checking code: check_root(), check_cpus()
> and check_memory() really aren't that useful.  They mostly check for
> the presence of particular nodes and properties.  That's inherently
> prone to false-positives, because we could be dealing with an
> artificial tree (like many of the testcases) or it could be expected
> that the missing properties are filled in by a bootloader or other
> agent.
> 
> If any of these checks really turns out to be useful, we can
> reimplement them later in a better conceived way on top of the new
> checking infrastructure.  For now, just get rid of them, removing the
> last vestiges of the old-style checking code (hoorah).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl
