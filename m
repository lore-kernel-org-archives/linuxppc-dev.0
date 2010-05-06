Return-Path: <anton@ozlabs.org>
Date: Thu, 6 May 2010 21:57:25 +1000
From: Anton Blanchard <anton@samba.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Disable CONFIG_SYSFS_DEPRECATED
Message-ID: <20100506115725.GB12203@kryten>
References: <20100506033041.GA12203@kryten>
	<20100506113816.GP2671@hansolo.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100506113816.GP2671@hansolo.jdub.homelinux.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi Josh,

> I'd like to run a few tests with this disabled on the 4xx boards first please.
> I can't say that all the boards I have will have any sort of "distro" to begin
> with, and if they did they might not be running something from the last 3 or
> 4 years.  I do run -git kernels on them frequently though.

Sounds reasonable. I was going to update only ppc64_defconfig and
pseries_defconfig but thought it would be nice to avoid our configs
diverging even more if we could avoid it.

Anton
