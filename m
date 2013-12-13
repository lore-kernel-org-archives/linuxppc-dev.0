Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A196B2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2013 13:59:10 +1100 (EST)
Message-ID: <1386903534.15730.62.camel@pasglop>
Subject: Re: powerpc/powernv: Framework to log critical errors on powernv.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 13 Dec 2013 13:58:54 +1100
In-Reply-To: <1386900030.21216.7.camel@concordia>
References: <52A99D47.4090503@linux.vnet.ibm.com>
 <1386900030.21216.7.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-12-13 at 13:00 +1100, Michael Ellerman wrote:
> None of the above seem to be used anywhere.

They are the arguments you pass when creating an error log, ie, they
are the values that are used by the firmware to generate the actual
error log entry.

They will be used as we add code that generate error log entries
subsequently.

Cheers,
Ben.
