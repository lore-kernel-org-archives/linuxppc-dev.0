Return-Path: <olof@lixom.net>
Date: Thu, 26 Apr 2007 17:32:28 -0500
To: Luke Browning <lukebr@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powerpc: 64K page support for kexec
Message-ID: <20070426223228.GA30000@lixom.net>
References: <1177626236.24866.99.camel@luke-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1177626236.24866.99.camel@luke-laptop>
From: olof@lixom.net (Olof Johansson)
Cc: Arnd Bergmann <arnd@arndb.de>, miltonm@bga.com, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 07:23:56PM -0300, Luke Browning wrote:
> This patch fixes a couple of kexec problems related to 64K page 
> support in the kernel.  kexec issues a tlbie for each pte.  The 
> parameters for the tlbie are the page size and the virtual address.
> Support was missing for the computation of these two parameters
> for 64K pages.  This patch adds that support.  
> 
> Signed-off-by: Luke Browning <lukebrowning@us.ibm.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
