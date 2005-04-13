Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 9C81867B6A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Apr 2005 21:54:37 +1000 (EST)
Date: Wed, 13 Apr 2005 07:52:13 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: "Tsang, Chi Kit" <chi@artesyncp.com>
In-Reply-To: <797470E884C6D611B7A500B0D0AA56D0F195AE@batistuta.spider.com>
Message-ID: <Pine.LNX.4.61.0504130751140.8358@localhost.localdomain>
References: <797470E884C6D611B7A500B0D0AA56D0F195AE@batistuta.spider.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: cpm_uart console problems?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 13 Apr 2005, Tsang, Chi Kit wrote:

> ttyCPM0 at MMIO 0xf0011a80 (irq = 4) is a CPM UART
> ...
> ...
>
> I currently do not specify the "console=ttyCPM" in my boot command
> line. Would this be an issue?

this may or may not help you but, with my 8xx board, i had to add
"console=ttyCPM0,9600" to my boot command line.

rday
