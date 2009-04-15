Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id C2A7CDE1B4
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 02:17:30 +1000 (EST)
Date: Wed, 15 Apr 2009 20:17:28 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: fixed phy -- how do we decide to use this code?
Message-ID: <20090415161728.GA5670@oksana.dev.rtsoft.ru>
References: <B660E2DF-5F6A-4939-9D20-3AB8E7C69EDB@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <B660E2DF-5F6A-4939-9D20-3AB8E7C69EDB@kernel.crashing.org>
Cc: netdev@vger.kernel.org, Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 15, 2009 at 10:54:40AM -0500, Kumar Gala wrote:
> Vitaly, Anton
>
> You guys have used this code.. I was wondering how we decide to used the 
> fixed phy vs another phy.  Is this a runtime decision based on something 
> in the device tree or purely at compile time?

It's specified via fixed-link property in the device tree.
The bindings described in Documentation/powerpc/dts-bindings/fsl/tsec.txt.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
