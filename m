Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 4CAC467B59
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 05:10:22 +1000 (EST)
Date: Tue, 15 Aug 2006 14:05:24 -0500
To: James K Lewis <jklewis@us.ibm.com>
Subject: Re: [PATCH 4/4]: powerpc/cell spidernet ethtool -i version number
	info.
Message-ID: <20060815190524.GW6603@pb15.lixom.net>
References: <20060811180013.GB6550@pb15.lixom.net>
	<OF934FE4E3.EEC44FDD-ON872571C7.00668651-862571C7.00677A44@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF934FE4E3.EEC44FDD-ON872571C7.00668651-862571C7.00677A44@us.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 11, 2006 at 01:50:19PM -0500, James K Lewis wrote:
>  Hi Olof,
> 
>   There are several reasons why an Ethernet driver should have an up to 
> date version number:
> 
> 1. Customers like to see they are really getting a new version.
> 
> 2. It makes it easier for support personnel (me in this case) to see which 
> driver they have. Sure, sometimes I can talk them thru doing a "sum" on 
> the .ko and all that, but why not just use the version number? That's what 
> it is for. And no, you can't just assume they have the version that came 
> with the kernel they are running. It doesn't work that way.
> 
> 3. It makes bug reporting easier. 
> 
> 4. I have already run into too many problems and wasted too much time 
> working with drivers when the number was NOT getting updated. 

Thanks for the info, Jim.

Sounds like it's most useful if a customer (or distro) takes the driver
out of the tree and run it with a different kernel, i.e. when kernel
and driver versions no longer go together. Makes sense.


-Olof
