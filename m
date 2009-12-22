Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 22 Dec 2009 11:18:19 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Joel Schopp <jschopp@austin.ibm.com>
Subject: Re: [PATCH] powerpc: update ibm,client-architecture
Message-ID: <20091222001819.GL30375@ozlabs.org>
References: <1261170452.8134.13.camel@jschopp-laptop>
	<20091221004458.GI30375@ozlabs.org>
	<4B2FBCD1.7080306@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4B2FBCD1.7080306@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 21, 2009 at 12:22:09PM -0600, Joel Schopp wrote:

> 4 is the new 2.  Since the actual threads per core is unknown at
> this point in boot you have to be conservative and go with the
> maximum number of any processor.  See page 4 of these charts:
> http://www.power.org/events/powercon09/taiwan09/IBM_Overview_POWER7.pdf

Sure P7 /can/ be 4-way SMT, but consider the case where you know you have 128
threads so you set NR_CPUS to 128, then you boot with "max cores" of 32, so you
lose half of your threads.  I guess that's only a problem when you build your
own kernels, distros are probably setting NR_CPUS high enough to cover all SMT2
systems anyway.

I guess if the patch only set the "max cores" and described why, I'd (FWIW :D)
be more comfortable.

Yours Tony
