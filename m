Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17745.14911.693171.717979@cargo.ozlabs.ibm.com>
Date: Wed, 8 Nov 2006 13:00:31 +1100
From: Paul Mackerras <paulus@samba.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] PowerPC: clockevents and HRT support
In-Reply-To: <45510C58.3010707@ru.mvista.com>
References: <200611080005.08633.sshtylyov@ru.mvista.com>
	<1162938997.28571.534.camel@localhost.localdomain>
	<45510C58.3010707@ru.mvista.com>
Cc: tglx@linutronix.de, greg.weeks@timesys.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov writes:

>     Arch-specific accounting hooks which this feature makes use of can't be 
> called from the generic clockevents code.

Which hooks specifically?

The deterministic accounting is an essential feature; there's no way
I'll accept a patch which disables it.

Paul.
