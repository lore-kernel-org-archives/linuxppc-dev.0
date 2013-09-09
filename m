Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1371E2C0113
 for <linuxppc-dev@ozlabs.org>; Mon,  9 Sep 2013 19:26:50 +1000 (EST)
Message-ID: <1378718795.11525.0.camel@pasglop>
Subject: Re: [RFC PATCH v3 04/12] Validate r1 value before going to host
 kernel in virtual mode.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Date: Mon, 09 Sep 2013 19:26:35 +1000
In-Reply-To: <20130909052930.GD6248@drongo>
References: <20130826192616.2855.18749.stgit@mars>
 <20130826193148.2855.95627.stgit@mars> <20130909052930.GD6248@drongo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-09-09 at 15:29 +1000, Paul Mackerras wrote:
> Are we guaranteed that Sapphire will keep the stack pointer positive
> at all times?  (More a question for Ben H than you.)

Good point, we *might* eventually set the top bit..

Ben.
