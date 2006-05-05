Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17498.59681.133131.336680@cargo.ozlabs.ibm.com>
Date: Fri, 5 May 2006 15:56:49 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/13] powerpc: export symbols for page size selection
In-Reply-To: <20060429233921.099214000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
	<20060429233921.099214000@localhost.localdomain>
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

> We need access to some symbols in powerpc memory management
> from spufs in order to create proper SLB entries.

I don't like exporting low-level implementation details like this, and
it seems a bit bogus to have an SLB miss handler in a module.  Could
you move the SLB miss handler to the non-modular part?

Regards,
Paul.
