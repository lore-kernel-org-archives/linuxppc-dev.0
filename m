Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17965.33063.766403.836286@cargo.ozlabs.ibm.com>
Date: Tue, 24 Apr 2007 14:01:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: Dave Jiang <djiang@mvista.com>
Subject: Re: [PATCH] add reg and stack dump to booke WD handler
In-Reply-To: <20070413221657.GA23624@blade.az.mvista.com>
References: <20070413173524.GA17890@blade.az.mvista.com>
	<461FCB6F.7010504@ru.mvista.com>
	<20070413200659.GA21588@blade.az.mvista.com>
	<B8CF9F53-9F51-4DD5-9CB6-16C69502A1CA@kernel.crashing.org>
	<20070413221657.GA23624@blade.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dave Jiang writes:

> Have the booke watchdog dump some useful information when triggered.
> Hopefully that'll give the user some hint of what happened rather than just a
> mysterious reboot.

Why not call either die() or panic()?  Won't they do what you want?

Paul.
