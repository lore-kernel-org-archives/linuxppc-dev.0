Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2FF531A0356
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 22:22:16 +1100 (AEDT)
Received: by mail-pa0-x22c.google.com with SMTP id fl4so11333997pad.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 03:22:16 -0800 (PST)
Subject: Re: [PATCH v8 8/8] livepatch: Detect offset for the ftrace location
 during build
To: Torsten Duwe <duwe@lst.de>
References: <20160212164517.GO12548@pathway.suse.cz>
 <20160216054701.GA20570@linux.vnet.ibm.com> <20160216082302.GA20522@lst.de>
 <20160216103028.GA10730@linux.vnet.ibm.com> <20160216103907.GB25103@lst.de>
 <20160216135742.GT12548@pathway.suse.cz>
 <1455678521.2956.4.camel@ellerman.id.au> <20160223170017.GB21932@lst.de>
 <56CD4FA0.4090109@gmail.com> <56CD53E7.3010108@gmail.com>
 <20160224092318.GA24232@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>,
 Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
 linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56CD925E.4060000@gmail.com>
Date: Wed, 24 Feb 2016 22:22:06 +1100
MIME-Version: 1.0
In-Reply-To: <20160224092318.GA24232@lst.de>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 24/02/16 20:23, Torsten Duwe wrote:
> On Wed, Feb 24, 2016 at 05:55:35PM +1100, Balbir Singh wrote:
>> <snip>
>>
>> We need to remove the SQUASH_TOC_SAVE_INSNS bits as well, now that the ppc64_profile_stub_insns does not save r2
> Sure -- this was meant to _replace_ the changes from patch 2/8, not on top.
> And yes, it exposes duplicate definitions, but does not cause them AFAICS.
> The two unasked questions about it were: Is Michael's solution on a similar
> basis? Is this worth any further effort e.g. put into v9?
>
>
My bad you did mention _replace_, but I think 2/8 and 6/8 of tightly bound
together, so the replacement is not straight forward. Yes, it is heading in
a similar direction, but it focuses mostly on ftrace. I think v9 makes sense,
but I'll let Michael comment on this as well]

Personally, I think your v8 or v9 + Michael's changes - RECORD_C_MCOUNT +
some changes (yet to code them based on v8/v9/ftrace stability) should get
the full live patching working.

Balbir Singh.
