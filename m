Return-Path: <jonmasters@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.193])
	by ozlabs.org (Postfix) with ESMTP id 4A6182BDD3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Oct 2004 09:05:44 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 75so693603rnl
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Oct 2004 16:05:43 -0700 (PDT)
Message-ID: <35fb2e590410121605a3e9b8b@mail.gmail.com>
Date: Wed, 13 Oct 2004 00:05:40 +0100
From: Jon Masters <jonmasters@gmail.com>
To: Rupesh S <rupesh.sugathan@gmail.com>,
	linuxppc-embedded@ozlabs.org
In-Reply-To: <35fb2e590410121603624c27a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <1e44ebcf04101214247d3072b6@mail.gmail.com>
	<20041012213634.GA4936@gate.ebshome.net>
	<35fb2e590410121603624c27a2@mail.gmail.com>
Cc: 
Subject: Re: PPC kernel hangs
Reply-To: jonathan@jonmasters.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 13 Oct 2004 00:03:21 +0100, Jon Masters <jonmasters@gmail.com> wrote:

> Possibly also use io_block_mapping on ppc to map a block of IO memory
> before ioremapping.

Actually, in this case that's a bad idea. Ignore that.

Jon.
