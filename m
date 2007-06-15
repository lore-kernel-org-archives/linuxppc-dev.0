Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 15829DDFB8
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 02:28:11 +1000 (EST)
Date: Fri, 15 Jun 2007 09:29:19 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: for-2.6.23 branch in powerpc.git created
Message-ID: <20070615162919.GA18055@mag.az.mvista.com>
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

On Fri, Jun 15, 2007 at 02:50:11PM +1000, Paul Mackerras wrote:

> The patches I put in are listed below.  If you have a patch that
> should go in but isn't listed, remind me about it.

Hi Paul.  I have a few too:

3 patches cleaning boot/Makefile when wrapping a dt:

http://patchwork.ozlabs.org/linuxppc/patch?id=11428
http://patchwork.ozlabs.org/linuxppc/patch?id=11429
http://patchwork.ozlabs.org/linuxppc/patch?id=11430

2 patches for mv64x60/prpmc2800 to use 'add_preferred_console()':

http://patchwork.ozlabs.org/linuxppc/patch?id=11585
http://patchwork.ozlabs.org/linuxppc/patch?id=11586

Mark
