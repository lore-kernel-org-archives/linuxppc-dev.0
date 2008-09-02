Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 17125DDE1A
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 03:58:14 +1000 (EST)
Date: Tue, 2 Sep 2008 13:06:06 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Reserve syscall number 319
Message-ID: <20080902180605.GA8240@lixom.net>
References: <20080902054941.77DA3DDDF0@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080902054941.77DA3DDDF0@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 02, 2008 at 03:48:45PM +1000, Benjamin Herrenschmidt wrote:
> Some stuff I'm working on that isn't released yet needs
> a syscall number but I can't say what it's for until I
> get permission to release it :-)
> 
> In the meantime, it would be nice if a number could be set
> aside so the tools being developped to use that stuff don't
> all need to be updated when things are eventually released.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> I wonder if I'll get hanged for that one :-)

Yes. Merge your code or live with the pain of things changing
underneath. Period.


-Olof
