Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id C56EC67C6E
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 06:18:09 +1000 (EST)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] fix ARCH=ppc timer_interrupt after global pt_regs
References: <871wp8ukh0.fsf@sleipner.barco.com>
	<1161029148.3172.19.camel@zod.rchland.ibm.com>
Date: Mon, 16 Oct 2006 22:18:05 +0200
In-Reply-To: <1161029148.3172.19.camel@zod.rchland.ibm.com> (Josh Boyer's
	message of "Mon, 16 Oct 2006 15:05:48 -0500")
Message-ID: <87slhot3pe.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "JB" == Josh Boyer <jwboyer@linux.vnet.ibm.com> writes:

Hi,

JB> Kumar Galak already fixed this on Oct 11 in the powerpc git tree.

Ahh, I didn't notice.

JB> Paul, could you send this fix to Linus soon please?

Yes, please - I spend most of the morning tracking this down.

-- 
Bye, Peter Korsgaard
