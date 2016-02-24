Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27FA11A0356
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 20:23:22 +1100 (AEDT)
Date: Wed, 24 Feb 2016 10:23:18 +0100
From: Torsten Duwe <duwe@lst.de>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>,
 Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 8/8] livepatch: Detect offset for the ftrace
 location during build
Message-ID: <20160224092318.GA24232@lst.de>
References: <20160212164517.GO12548@pathway.suse.cz>
 <20160216054701.GA20570@linux.vnet.ibm.com> <20160216082302.GA20522@lst.de>
 <20160216103028.GA10730@linux.vnet.ibm.com> <20160216103907.GB25103@lst.de>
 <20160216135742.GT12548@pathway.suse.cz>
 <1455678521.2956.4.camel@ellerman.id.au> <20160223170017.GB21932@lst.de>
 <56CD4FA0.4090109@gmail.com> <56CD53E7.3010108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56CD53E7.3010108@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 24, 2016 at 05:55:35PM +1100, Balbir Singh wrote:
> <snip>
> 
> We need to remove the SQUASH_TOC_SAVE_INSNS bits as well, now that the ppc64_profile_stub_insns does not save r2

Sure -- this was meant to _replace_ the changes from patch 2/8, not on top.
And yes, it exposes duplicate definitions, but does not cause them AFAICS.
The two unasked questions about it were: Is Michael's solution on a similar
basis? Is this worth any further effort e.g. put into v9?

	Torsten
