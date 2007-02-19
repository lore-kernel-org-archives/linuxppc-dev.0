Return-Path: <agl@us.ibm.com>
Subject: Re: [PATCH] powerpc: Introduce address space "slices"
From: Adam Litke <agl@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1171867418.18571.3.camel@localhost.localdomain>
References: <1171867418.18571.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 19 Feb 2007 12:54:41 -0600
Message-Id: <1171911281.22940.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Patch seems good to me.  I tried it on my power4+ system and it was not
happy.  Have you tested on Power4 at all? 

On Mon, 2007-02-19 at 17:43 +1100, Benjamin Herrenschmidt wrote:
> powerpc: Introduce address space "slices"

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center
