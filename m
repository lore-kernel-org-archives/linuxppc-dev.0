Return-Path: <tpepper@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.225])
	by ozlabs.org (Postfix) with ESMTP id 61BCBDDE21
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 06:37:01 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1403622nzh
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Nov 2007 11:36:59 -0800 (PST)
Message-ID: <eada2a070711061136l18ac7651h85bf3da19a79b669@mail.gmail.com>
Date: Tue, 6 Nov 2007 11:36:58 -0800
From: "Tim Pepper" <lnxninja@us.ibm.com>
Sender: tpepper@gmail.com
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"External List" <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC/PATCH 0/2] powerpc: 64 bits irqtrace / lockdep support
In-Reply-To: <1192433296.924212.737979117370.qpush@grosgo>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1192433296.924212.737979117370.qpush@grosgo>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/14/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> This is 2 patches, one from Christoph Hellwig that adds the backtrace support,
> and one from Johannes Berg modified by me that adds the irq tracing support.
>
> This successfully boots a POWER5 pSeries machine. I'm going to run some more
> tests in the upcoming few days, so this is not an official submission (and it's
> too late for .24 merge window anyway) but it's looking good so far.

FYI: Boots and survives watching /proc/lock_stat during a kernel build
for me (on a 970 based blade).


Tim
