Return-Path: <anton@ozlabs.org>
Date: Fri, 13 Aug 2010 15:38:18 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add support for popcnt instructions
Message-ID: <20100813053818.GZ29316@kryten>
References: <20100813022809.GY29316@kryten> <1281673744.2987.362.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281673744.2987.362.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi,

> Especially from modules it will suck big time. If kept out of line they
> should probably be linked-in with each module, but I'd rather have them
> inlined.

Inlining would be good, but this is as far as I can take this for now.
If someone else is interested go for it :)

Anton
