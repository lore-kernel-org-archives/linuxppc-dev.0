Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18723.34405.785532.840360@cargo.ozlabs.ibm.com>
Date: Wed, 19 Nov 2008 14:22:13 +1100
From: Paul Mackerras <paulus@samba.org>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH] powerpc: Silence timebase sync code
In-Reply-To: <1226959111-11221-1-git-send-email-tpiepho@freescale.com>
References: <1226959111-11221-1-git-send-email-tpiepho@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trent Piepho writes:

> It's over a dozen lines of output and doesn't appear to provide any useful
> information.  Even after looking at the code, I'm in the dark about what
> "score 299, offset 250" means.

I already put a very similar patch from Ben Herrenschmidt into my
powerpc.git tree next branch, back on 5 November.

Paul.
