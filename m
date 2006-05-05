Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 07/13] powerpc: export symbols for page size selection
Date: Fri, 5 May 2006 11:12:33 +0200
References: <20060429232812.825714000@localhost.localdomain>
	<20060429233921.099214000@localhost.localdomain>
	<17498.59681.133131.336680@cargo.ozlabs.ibm.com>
In-Reply-To: <17498.59681.133131.336680@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605051112.34413.arnd.bergmann@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 05 May 2006 07:56, Paul Mackerras wrote:
> I don't like exporting low-level implementation details like this, and
> it seems a bit bogus to have an SLB miss handler in a module.  Could
> you move the SLB miss handler to the non-modular part?

Yes. The series already has the patches to move the SLB miss handler
into the built-in parts. At the moment, we also need the symbols for
the context switch code that also touches the SLB entries. We already
have a patch to move that as well, but are still discussing the details
of that.

I'll follow up with a patch to replace this one.

	Arnd <><
