Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17752.16589.182362.143760@cargo.ozlabs.ibm.com>
Date: Mon, 13 Nov 2006 20:54:21 +1100
From: Paul Mackerras <paulus@samba.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH] CPM_UART: Fix non-console initialisation (v2)
In-Reply-To: <20061113112230.4c1af7b0@localhost.localdomain>
References: <Pine.LNX.4.64.0611011457490.3387@host32.eke.fi>
	<17748.21645.621069.105453@cargo.ozlabs.ibm.com>
	<a425f86c0611100345h40b104cchdb766e35f1767656@mail.gmail.com>
	<Pine.LNX.4.64.0611101359200.25024@host32.eke.fi>
	<17749.46096.241328.470093@cargo.ozlabs.ibm.com>
	<20061113112230.4c1af7b0@localhost.localdomain>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vitaly Bordug writes:

> patch with proper description inlined.
> 
> Thanks,
> -Vitaly
> ---
> [POWERPC] CPM_UART: Fixes inconsistency of function definition
> 
> From: Kalle Pokki <kalle.pokki@iki.fi>
> 
> The below hunk was missed from the recent patch, and now, there are somewhat 
> inconsistent definitions:

Well, what I want to know is this: why was the addition of __init
bundled in with what I was told was a bug-fix that was needed for
2.6.19?  Does the addition of __init fix a bug somehow?

Paul.
