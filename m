Return-Path: <michael@ellerman.id.au>
Date: Mon, 22 Apr 2013 09:27:57 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND] powerpc/rtas_flash: Free kmem upon module exit
Message-ID: <20130421232757.GA22246@concordia>
References: <20130419114737.20439.54937.stgit@hegdevasant>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130419114737.20439.54937.stgit@hegdevasant>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 19, 2013 at 05:18:09PM +0530, Vasant Hegde wrote:
> Memory allocated to flash_block_list in rtas_flash_write
> is not freed during module exit. We hit below call trace
> if we unload rtas_flash module after loading new firmware
> image and before rebooting the system.

Why the resend? Did anything change?

cheers
