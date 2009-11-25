Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id 660CC1007D1
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Nov 2009 10:02:03 +1100 (EST)
Date: Thu, 26 Nov 2009 09:33:27 +1100
From: Simon Horman <horms@verge.net.au>
To: "M. Mohan Kumar" <mohan@in.ibm.com>
Subject: Re: [PATCH] Write to HVC terminal from purgatory cod
Message-ID: <20091125223327.GJ4794@verge.net.au>
References: <20091016062602.GC4995@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091016062602.GC4995@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 16, 2009 at 11:56:02AM +0530, M. Mohan Kumar wrote:
> [PATCH] Write to HVC terminal from purgatory code
> 
> Current x86/x86-64 kexec-tools print the message "I'm in purgatory" to serial
> console/VGA while executing the purgatory code.  Implement this feature for
> POWERPC pseries platform by using the H_PUT_TERM_CHAR hypervisor call by
> printng to hvc console.
> 
> Includes the changes suggested by Michael Ellerman

Sorry for the long delay, applied.
