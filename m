Return-Path: <kumar.gala@freescale.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id A22802BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Oct 2004 07:13:13 +1000 (EST)
In-Reply-To: <20041015165538.GB4131@logos.cnet>
References: <20041015165538.GB4131@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <04442B50-1EEF-11D9-BAB6-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 15 Oct 2004 16:13:10 -0500
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: "Nei A. Chiaradia" <nei.chiaradia@cyclades.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
	Wanda Rosalino <wanda.rosalino@cyclades.com>,
	Regina Kodato <regina.kodato@cyclades.com>
Subject: Re: [PATCH] PRxK sub-architecture
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

(realized after the fact that this belonged on linuxppc-embedded)

A few comments:

1. Any reason for the duplicated header between include/asm-ppc/prxk.h 
& arch/ppc/platforms/prxk.h?
2. Does flash.h really belong in include/asm-ppc?

- kumar

[snip]
