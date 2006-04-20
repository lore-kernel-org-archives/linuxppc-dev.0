Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id EA3CB679FB
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 03:31:27 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4447C3BA.6050709@am.sony.com> 
References: <4447C3BA.6050709@am.sony.com> 
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch] powerpc: move PAGE_SIZE outside #ifdef __KERNEL__ 
Date: Thu, 20 Apr 2006 18:31:21 +0100
Message-ID: <15231.1145554281@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand <geoffrey.levand@am.sony.com> wrote:

> The procps package needs PAGE_SIZE, defined in asm-powerpc/page.h,
> but it is defined inside "#ifdef __KERNEL__".
> 
> This moves the PAGE_SIZE definition outside of "#ifdef __KERNEL__".

Why do you want to do that?  Userspace shouldn't be using PAGE_SIZE directly.

David
