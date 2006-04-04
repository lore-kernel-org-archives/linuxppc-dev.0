Return-Path: <anton@ozlabs.org>
Date: Tue, 4 Apr 2006 22:42:48 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH] powerpc: Use rtas query-cpu-stopped-state in smp
	spinup
Message-ID: <20060404124248.GA26436@krispykreme>
References: <20060404112459.C9170679EB@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060404112459.C9170679EB@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

> Currently we use a cpumask called of_spin_map to keep track of which threads
> have been spun up. We basically guess that OF has spun up all even numbered
> threads, and so all the odd numbered threads need to be brought up.
> 
> That's a bit of a dicey assumption at best, and is totally incorrect for
> kexec. Luckily we have an rtas call which can tell us whether a cpu is up
> or not, so let's use it?

I have a bad feeling its broken on some older (POWER3) machines.

Anton
