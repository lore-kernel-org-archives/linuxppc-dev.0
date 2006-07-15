Return-Path: <anton@ozlabs.org>
Date: Sun, 16 Jul 2006 08:07:58 +1000
From: Anton Blanchard <anton@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
Message-ID: <20060715220757.GA31511@krispykreme>
References: <20060714233739.GA11487@monkey.ibm.com>
	<200607150200.03494.arnd@arndb.de>
	<20060715153053.GK31081@krispykreme>
	<200607151842.27568.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200607151842.27568.arnd@arndb.de>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>, Paul Mackerras <paulus@samba.org>,
	Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
> Not sure I follow you. I would expect the PURR value to be restored after
> a context switch, even if we continue on a different physical CPU.
> 
> The idea behind monitoring both PURR and timebase is that the difference
> between the two tells you how long the partition was suspended during
> the hcall.

Sounds good, last time I looked at the patch I thought it was gathering
the PURR only. That on its own would make for some confusing results.

Anton
