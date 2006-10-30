Return-Path: <fabbione@ubuntu.com>
Received: from trider-g7.fabbione.net (trider-g7.fabbione.net [195.22.207.161])
	by ozlabs.org (Postfix) with ESMTP id 7AA8067CB0
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 22:35:50 +1100 (EST)
Message-ID: <4545E38B.5010702@ubuntu.com>
Date: Mon, 30 Oct 2006 12:35:39 +0100
From: Fabio Massimo Di Nitto <fabbione@ubuntu.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: glibc-2.5 test suite hangs/crashes the machine
References: <45419F79.2020300@ubuntu.com>
	<1162177334.25682.144.camel@localhost.localdomain>
In-Reply-To: <1162177334.25682.144.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Jeff Bailey <jbailey@ubuntu.com>,
	Paul Mackerras <paulus@samba.org>, Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> Does that patch fixes it ?
> 

tested with kernel .17 and headers from .19 and the build hangs. Still tons of
Zl processes around.

On the note building with kernel .19 and .19 headers it all goes smooth.

Fabio

-- 
I'm going to make him an offer he can't refuse.
