Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B5EF67B99
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 11:12:03 +1100 (EST)
Date: Fri, 10 Feb 2006 18:03:27 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: atul.sabharwal@exgate.tek.com
Subject: RE: kernel startup
In-Reply-To: <4A062D477D842B4C8FC48EA5AF2D41F201BA2084@us-bv-m23.global.tektronix.net>
Message-ID: <Pine.LNX.4.44.0602101802590.31619-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Fri, 10 Feb 2006 atul.sabharwal@exgate.tek.com wrote:

> Since I have set IIP to 1, reset vector is at 0xfff00100.  IMMR is
> 0x00f00000. So, putting RAM at address 0x0 allows only 15MB of RAM
> at address 0x0 (ISA style). 

I'm not that familiar with 8xx, but can't you move IMMR?

- kumar
