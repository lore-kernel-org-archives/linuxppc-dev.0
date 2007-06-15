Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id F2392DDFBA
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 03:27:42 +1000 (EST)
Date: Fri, 15 Jun 2007 12:27:32 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: for-2.6.23 branch in powerpc.git created
Message-ID: <20070615172732.GD6369@localdomain>
References: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul-

Paul Mackerras wrote:
>
> If you have a patch that should go in but isn't listed, remind me
> about it.

Please consider picking up "remove spinlock from struct
cpu_purr_data" for 2.6.23:

http://patchwork.ozlabs.org/linuxppc/patch?id=11291
