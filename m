Return-Path: <bwarren@qstreams.com>
Received: from web310.biz.mail.mud.yahoo.com (web310.biz.mail.mud.yahoo.com
	[68.142.199.186]) by ozlabs.org (Postfix) with SMTP id DC013DDE38
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Mar 2007 02:20:58 +1100 (EST)
Date: Thu, 8 Mar 2007 07:20:56 -0800 (PST)
From: Ben Warren <bwarren@qstreams.com>
Subject: Re: RE : Reset cause API
To: alayrac <christophe.alayrac@cresitt.com>, galak@kernel.crashing.org,
	linuxppc-embedded@ozlabs.org
In-Reply-To: <000501c7618f$89492bc0$c900a8c0@CRESITTLAB>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <988938.70070.qm@web310.biz.mail.mud.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks Chris & Kumar,
--- alayrac <christophe.alayrac@cresitt.com> wrote:


> The type of reset is recorded in the most-recent
> reset field of the
> debug-status register (DBSR[MRR]). System software
> can examine this
> field if it needs to determine the cause of a reset.
> The effect of a
> reset on the processor is always the same regardless
> of the type.
> 
> For more details you can see ppc-ref-guide.pdf (in
> EDK doc directory).
> Chris

The Freescale SoCs also have a Reset Status Register
(RSR) than contains the same kind of information.  I
wa s curious whether a system call exists or whether I
need to write my own.

What I'm really interested in knowing is whether the
last boot was cold(hard) or warm(soft).  The type of
products I work on have devices that must only be
initialized on a cold boot, to avoid affecting the
data path.

regards,
Ben 
