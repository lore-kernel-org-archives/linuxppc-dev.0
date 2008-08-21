Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18604.62202.618599.18902@drongo.ozlabs.ibm.com>
Date: Thu, 21 Aug 2008 14:45:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 1/4] powerpc: Fix typo in pgtable-ppc64.h
In-Reply-To: <48AC7C1D.5070509@am.sony.com>
References: <48AC78BA.3070902@am.sony.com>
	<48AC7C1D.5070509@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geoff Levand writes:

> Fix a minor comment typo in pgtable-ppc64.h.

I don't see why this needs to go in 2.6.27.  See Linus' recent
comments on what should go in outside the merge window:

http://lkml.org/lkml/2008/8/20/251

I'll queue it for 2.6.28.

Paul.
