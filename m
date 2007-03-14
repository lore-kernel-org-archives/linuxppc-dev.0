Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17911.24243.64287.434769@cargo.ozlabs.ibm.com>
Date: Wed, 14 Mar 2007 13:32:19 +1100
From: Paul Mackerras <paulus@samba.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch] PS3: Fix hardware watchpoints
In-Reply-To: <45F74D69.5070600@am.sony.com>
References: <45F74D69.5070600@am.sony.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand writes:

> Add PS3 support for the PowerPC processor's Data Address Breakpoint
> Register (DABR).
> 
> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> ---
> Paul, please consider for 2.6.21.

It's nice and small, but it isn't really a bugfix as far as I can
see...  What's the downside of it not going into 2.6.21, apart from
some inconvenience in debugging things?

Paul.
