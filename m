Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17221.45591.341270.888791@cargo.ozlabs.ibm.com>
Date: Fri, 7 Oct 2005 09:24:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: Giuliano Pochini <pochini@shiny.it>
In-Reply-To: <XFMail.20050929092052.pochini@shiny.it>
References: <1127865914.6102.0.camel@gaston>
	<XFMail.20050929092052.pochini@shiny.it>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Starting the arch/powerpc merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Giuliano Pochini writes:

> Out of curiosity, is there any advantage in using a 32 bits
> kernel on ppc64 over a 64 bits kernel ?  Speed ?  Complexity ?
> Compatibility ?  Memory ?

Not really.  The main thing in the past has been that DRI with 32-bit
X server and clients would work with a 32-bit kernel but not a 64-bit
kernel, but that's fixed now.  A 64-bit kernel is faster on most
lmbench tests.  I guess a 32-bit kernel might end up a little smaller,
but that's the only possible advantage I can think of.

Paul.
