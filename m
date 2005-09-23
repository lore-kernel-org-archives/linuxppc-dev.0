Return-Path: <anton@ozlabs.org>
Date: Fri, 23 Sep 2005 17:44:13 +1000
From: Anton Blanchard <anton@samba.org>
To: David Howells <dhowells@redhat.com>
Message-ID: <20050923074413.GD19971@krispykreme>
References: <E1EIXAI-0006Q0-OS@jdl.com>
	<606.1127460740@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <606.1127460740@warthog.cambridge.redhat.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: PATCH powerpc Merge asm-ppc*/rwsem.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> rwsems on ppc64 should really be using a 64-bit counter, not a 32-bit counter,
> otherwise you limit the maximum number of processes to 32K-ish.
> 
> The counter should be "signed long" really.

Agreed, we should move to a 64bit count.

Anton
