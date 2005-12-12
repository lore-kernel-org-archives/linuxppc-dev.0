Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17308.57447.992759.27443@cargo.ozlabs.ibm.com>
Date: Mon, 12 Dec 2005 13:28:55 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
In-Reply-To: <F6AD7E21CDF4E145A44F61F43EE6D939486E0C@tmnt04.transmode.se>
References: <F6AD7E21CDF4E145A44F61F43EE6D939486E0C@tmnt04.transmode.se>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Linux process ABI broken in 2.6?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joakim Tjernlund writes:

> Is it too much trouble to define r7 to always have
> a zero
> value at process startup?

That's not much trouble, but what will you do for existing kernels?
Won't you have to do something like testing *r1 anyway?

Paul.
