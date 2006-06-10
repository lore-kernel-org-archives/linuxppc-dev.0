Return-Path: <anton@ozlabs.org>
Date: Sat, 10 Jun 2006 12:04:54 +1000
From: Anton Blanchard <anton@samba.org>
To: John Rose <johnrose@austin.ibm.com>
Subject: Re: [PATCH] reorg RTAS delay code
Message-ID: <20060610020453.GF23891@krispykreme>
References: <1149103929.2524.8.camel@sinatra.austin.ibm.com>
	<1149139866.28307.32.camel@localhost.localdomain>
	<1149177349.9812.16.camel@sinatra.austin.ibm.com>
	<1149200718.15158.0.camel@sinatra.austin.ibm.com>
	<1149280229.18052.3.camel@sinatra.austin.ibm.com>
	<20060602213308.GP8934@localdomain>
	<1149543108.17307.6.camel@sinatra.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1149543108.17307.6.camel@sinatra.austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Nathan Lynch <ntl@pobox.com>,
	External List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi John,

> This patch attempts to handle RTAS "busy" return codes in a more simple
> and consistent manner.  Typical callers of RTAS shouldn't have to
> manage wait times and delay calls.
> 
> This patch also changes the kernel to use msleep() rather than udelay()
> when a runtime delay is necessary.  This will avoid CPU soft lockups
> for extended delay conditions.

Looks like you missed one:

WARNING: ".rtas_extended_busy_delay_time" [arch/powerpc/platforms/pseries/scanlog.ko] undefined!

Anton
