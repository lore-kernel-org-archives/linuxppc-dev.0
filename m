Return-Path: <paulus@ozlabs.org>
Date: Sat, 10 Aug 2013 13:44:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Use ibm,chip-id property to compute
 cpu_core_mask if available
Message-ID: <20130810034436.GC5240@iris.ozlabs.ibm.com>
References: <20130704030506.GA2396@iris.ozlabs.ibm.com>
 <520498A4.9050805@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <520498A4.9050805@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 09, 2013 at 12:52:12PM +0530, Vasant Hegde wrote:
> Paul,
> 
> I wanted to test this patch but not able to apply this patch on top
> of Linux tree. Looks like I'm missing traverse_core_siblings()
> related patch. I searched in ppc mailing list and couldn't figure
> out.

Oops, my fault, there were actually 2 patches in that series but
somehow I only posted the second one.  I'll repost both patches.

Paul.
