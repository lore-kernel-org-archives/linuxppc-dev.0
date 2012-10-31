Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E76D42C00DE
 for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2012 18:22:46 +1100 (EST)
Message-ID: <1351668137.4047.38.camel@twins>
Subject: Re: [RFC][PATCH] perf: Add a few generic stalled-cycles events
From: Peter Zijlstra <peterz@infradead.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Wed, 31 Oct 2012 08:22:17 +0100
In-Reply-To: <20121031064056.GA12061@us.ibm.com>
References: <20121012012839.GA15348@us.ibm.com>
 <20121015155534.GR8285@erda.amd.com> <20121016100809.GS8285@erda.amd.com>
 <20121016183148.GA25482@us.ibm.com> <1351081662.22332.13.camel@twins>
 <20121031064056.GA12061@us.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Robert Richter <robert.richter@amd.com>,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 eranian@google.com, acme@redhat.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
 mpjohn@us.ibm.com, mingo@kernel.org, asharma@fb.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-10-30 at 23:40 -0700, Sukadev Bhattiprolu wrote:
> So instead of the names I came up with in this patch, stalled-cycles-fixe=
d-point
> we could use the name used in the CPU spec - 'cmplu_stall_fxu' in the arc=
h
> specific code ?=20

You could, but I would advise against it. Human readable names are so
much more accessible.
