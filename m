Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18149.45028.597999.740370@cargo.ozlabs.ibm.com>
Date: Tue, 11 Sep 2007 06:58:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] powerpc: Don't use generic machine check parsing
	everywhere
In-Reply-To: <20070905024159.GB27139@lixom.net>
References: <20070905024159.GB27139@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> If a platform provide it's own machine check handler, assume that code
> will handle the reason parsing and reporting the error. The current
> default fall-though only makes sense on a few 32-bit platforms that
> lack individual handlers.

Might be nice to put that code into a function of its own, called
print_6xx_machine_check or something similar.

Paul.
