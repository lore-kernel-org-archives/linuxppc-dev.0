Return-Path: <anton@samba.org>
Date: Mon, 7 Apr 2014 11:22:36 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] fixup: "powerpc/perf: Add support for the hv 24x7
 interface"
Message-ID: <20140407112236.3d65d99b@kryten>
In-Reply-To: <1396828110.3671.21.camel@pasglop>
References: <1396476654-20623-1-git-send-email-cody@linux.vnet.ibm.com>
 <1396476654-20623-2-git-send-email-cody@linux.vnet.ibm.com>
 <1396828110.3671.21.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Cody P Schafer <cody@linux.vnet.ibm.com>, cody+local@linux.vnet.ibm.com,
 LKML <linux-kernel@vger.kernel.org>, Michael Ellerman <michael@ellerman.id.au>,
 David.Laight@aculab.com, Linux PPC <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

> That's not much less awful... The message gives 0 informations about
> where it comes from .. what is it that couldn't obtain capabilities ?

Cody is at least using pr_fmt to give some information on what went
wrong:

[    1.635040] hv-24x7: not a virtualized system, not enabling
[    1.635079] hv-gpci: not a virtualized system, not enabling

I think this is way too chatty though. If every driver printed a couple
of lines we'd end up with thousands of useless lines in the dmesg.

I still would prefer to see these as pr_debug lines.

Anton
