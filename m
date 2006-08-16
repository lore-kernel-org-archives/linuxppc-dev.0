Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17634.40549.377775.121184@cargo.ozlabs.ibm.com>
Date: Wed, 16 Aug 2006 14:26:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Add CONFIG_POWERPC
In-Reply-To: <20060816041617.690EB67A3F@ozlabs.org>
References: <20060816041617.690EB67A3F@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman writes:

> We don't seem to have a top-level config symbol like other archs do. We have
> PPC64 and PPC, but I think it'd be cleaner to have just one for cases where
> we really mean PPC64 and/or PPC.

CONFIG_PPC already means either 32-bit or 64-bit PowerPC (always has
done, even before the merge).

Paul.
