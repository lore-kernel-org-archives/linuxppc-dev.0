Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0ED021007D1
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Nov 2011 16:24:56 +1100 (EST)
Message-ID: <1322198672.32635.24.camel@pasglop>
Subject: Re: oprofile callgraph support missing for common cpus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 25 Nov 2011 16:24:32 +1100
In-Reply-To: <OFD2223A5C.914A7555-ONC125794C.002D68B7-C125794C.002DFF90@transmode.se>
References: <OFD9ADD493.27DB131E-ONC125794B.002E2035-C125794B.002F715A@transmode.se>
 <4EC544C6.3050502@us.ibm.com>
 <A8CB2347-27B6-482A-B49B-F434FBFCBC10@freescale.com>
 <OF8F2311F0.71A00B7A-ONC125794B.007583D0-C125794B.0075E666@transmode.se>
 <20111117232027.GW15738@erda.amd.com>
 <OFD2223A5C.914A7555-ONC125794C.002D68B7-C125794C.002DFF90@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Robert Richter <robert.richter@amd.com>, linuxppc-dev@ozlabs.org,
 Andy Fleming <afleming@freescale.com>, oprofile-list@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-11-18 at 09:22 +0100, Joakim Tjernlund wrote:

> I forgot to ask, oprofile mentions setting -no-omit-framepointer to get
> correct backtrace but I cannot turn on frame pointers for the ppc kernel.
> Isn't frame pointers needed for pcc? what about user space?

PowerPC always has frame pointers, ignore that :-)

Cheers,
Ben.
