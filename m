Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18752.16188.480990.923571@cargo.ozlabs.ibm.com>
Date: Thu, 11 Dec 2008 09:14:20 +1100
From: Paul Mackerras <paulus@samba.org>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/8] fix bootmem reservation on uninitialized node
In-Reply-To: <20081209182130.1E4C1438@kernel>
References: <20081209182130.DB2150A2@kernel> <20081209182130.1E4C1438@kernel>
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
	linuxppc-dev@ozlabs.org, "Serge E. Hallyn" <serue@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dave Hansen writes:

> This patch ensures that we do not touch bootmem for any node which
> has not been initialized.
> 
> Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>

So, should I be sending this to Linus for 2.6.28?

I notice you have added a dbg() call.  For a 2.6.28 patch I'd somewhat
prefer not to have that in unless necessary.

Jon, does this patch fix the problem on your machine with 16G pages?

Paul.
