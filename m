Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: rr tree build failure
Date: Fri, 24 Oct 2008 00:31:22 +1100
References: <20081023155228.c8fa9da8.sfr@canb.auug.org.au>
In-Reply-To: <20081023155228.c8fa9da8.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810240031.22759.rusty@rustcorp.com.au>
Cc: linux-next@vger.kernel.org, Mike Travis <travis@sgi.com>,
	Arnd Bergmann <arnd@arndb.de>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 23 October 2008 15:52:28 Stephen Rothwell wrote:
> Hi Rusty,
>
> Today's linux-next build (powerpc ppc64_defconfig) failed like this:
>
> arch/powerpc/platforms/cell/spu_base.c: In function
> 'mm_needs_global_tlbie': arch/powerpc/platforms/cell/spu_base.c:117: error:
> implicit declaration of function '__cpus_setall'

OK, after discussions with Arnd I applied two fixes.  One is similar to yours 
but neater, and the other then changes NR_CPUS to nr_cpu_ids once it becomes 
available for UP.

Thanks,
Rusty.
