Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 82E5BDE01A
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 14:08:49 +1100 (EST)
Date: Sun, 28 Oct 2007 22:16:46 -0500
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [POWERPC] Fix duplicate time accounting
Message-ID: <20071029031646.GB14199@lixom.net>
References: <18213.19066.134475.220466@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18213.19066.134475.220466@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 29, 2007 at 01:50:34PM +1100, Paul Mackerras wrote:
> Currently, process user and system times are advancing twice as fast
> as they should because they are being accounted in two places - in the
> generic code and in timer_interrupt.  This fixes it by removing the
> call to account_process_time in timer_interrupt.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Tested-by: Olof Johansson <olof@lixom.net>

Thanks for fixing it!

-Olof
