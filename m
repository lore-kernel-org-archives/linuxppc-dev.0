Return-Path: <anton@ozlabs.org>
Date: Mon, 7 Jun 2010 10:46:57 +1000
From: Anton Blanchard <anton@samba.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Disable CONFIG_SYSFS_DEPRECATED
Message-ID: <20100607004657.GJ28295@kryten>
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

Any luck with this? I can submit a patch to fix the 64bit platforms and ignore
all 32bit if there is going to be a problem.

Anton
