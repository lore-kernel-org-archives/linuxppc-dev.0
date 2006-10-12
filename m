Return-Path: <linas@austin.ibm.com>
Date: Thu, 12 Oct 2006 11:18:45 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] Add support for stopping spus from xmon
Message-ID: <20061012161845.GY4381@austin.ibm.com>
References: <1160654587.449977.520618728447.qpush@concordia>
	<20061012120310.6B5A967BD5@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061012120310.6B5A967BD5@ozlabs.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 12, 2006 at 10:03:08PM +1000, Michael Ellerman wrote:
> 
>  arch/powerpc/platforms/cell/spu_base.c |    4 
>  arch/powerpc/xmon/xmon.c               |  142 ++++++++++++++++++++++++++++++++-
>  include/asm-powerpc/xmon.h             |    2 
>  3 files changed, 146 insertions(+), 2 deletions(-)

The next patch adds another 60 lines to xmon.c, which 
is already a bit too big. Perhaps you could instead
put this code in "xmon/cell.c" or something like that?

--linas
