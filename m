Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17447.25413.486950.115568@cargo.ozlabs.ibm.com>
Date: Mon, 27 Mar 2006 15:00:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <abergman@de.ibm.com>
Subject: Re: [patch 01/13] powerpc: hvc_console updates
In-Reply-To: <20060323203520.909999000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<20060323203520.909999000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann writes:

> Also shuffle around some data-type declarations and moves some
> functions out of include/asm-ppc64/hvconsole.h and into a new
> drivers/char/hvc_console.h file.

Unfortunately this causes compile failures because the declarations of
hvc_instantiate and hvc_alloc in include/asm-powerpc/hvconsole.h now
don't have the definition of struct hv_ops available to them.  I'll
ignore your 1/13 and 2/13 patches for now - please send fixed
versions.

Paul.
