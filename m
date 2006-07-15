Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id B81E3679E0
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 10:00:16 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
Date: Sat, 15 Jul 2006 02:00:02 +0200
References: <20060714233739.GA11487@monkey.ibm.com>
In-Reply-To: <20060714233739.GA11487@monkey.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607150200.03494.arnd@arndb.de>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, Nathan Lynch <ntl@pobox.com>,
	Paul Mackerras <paulus@samba.org>, Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 15 July 2006 01:37, Mike Kravetz wrote:
> In addition, there has been some discussion of these patches on IRC.
> Some remaining issues/questions are:
> - Exactly how much overhead does the statistic gathering introduce?
> - What would be the cost of disabling preemption for more accurate statistics?
> - What would be the cost of disabling interrupts for more accurate statistics?
> - Should we extend this statistic gathering to RTAS calls?

What happened to the question whether to use PURR values for also measuring
cycles spent executing the hcall as opposed to cycles that passed before
the hcall returns. Did that turn out not giving extra information after all
or was there a different reason to drop that idea?

	Arnd <><
