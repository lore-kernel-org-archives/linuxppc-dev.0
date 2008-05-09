Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18467.57545.798170.20885@cargo.ozlabs.ibm.com>
Date: Fri, 9 May 2008 15:27:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH]: PPC_OF protect USB driver...
In-Reply-To: <20080505.005715.215572318.davem@davemloft.net>
References: <20080505.005715.215572318.davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller writes:

> This uses APIs that are not generic, or at least not part of
> what Sparc provides yet.
> 
> So just PPC_OF this for now just like the EHCI_OF driver.
> 
> This fixes allmodconfig build errors on sparc.

Are you going to send this to the USB maintainers, or are you going to
merge it to Linus, or do you want me to?

Paul.
