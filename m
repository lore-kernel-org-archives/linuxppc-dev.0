Return-Path: <anton@samba.org>
Date: Tue, 25 Mar 2014 21:43:56 +1100
From: Anton Blanchard <anton@samba.org>
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 09/11] powerpc/perf: add support for the hv 24x7
 interface
Message-ID: <20140325214356.4a2f7d95@kryten>
In-Reply-To: <1394064082-6242-10-git-send-email-cody@linux.vnet.ibm.com>
References: <1394064082-6242-1-git-send-email-cody@linux.vnet.ibm.com>
 <1394064082-6242-10-git-send-email-cody@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Michael Ellerman <michael@ellerman.id.au>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, scottwood@freescale.com,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Cody,

hv-24x7: could not obtain capabilities, error 0x                                                                fffffffffffffffe, not enabling
hv-gpci: could not obtain capabilities, error 0x                                                                fffffffffffffffe, not enabling

> +		pr_info("could not obtain capabilities, error 0x%80lx, not enabling\n",

That's a lot of padding :)

I think this should also be a pr_debug, considering this is not relevant
to most ppc64 boxes.

Anton
