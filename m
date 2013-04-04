Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 925942C0119
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 18:16:21 +1100 (EST)
Message-ID: <1365059775.31207.3.camel@pasglop>
Subject: Re: [PATCH v2 2/11] Add PRRN Event Handler
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Date: Thu, 04 Apr 2013 09:16:15 +0200
In-Reply-To: <20130404033436.GC19443@drongo>
References: <51509AE8.8070803@linux.vnet.ibm.com>
 <51509CF0.10200@linux.vnet.ibm.com> <20130404033436.GC19443@drongo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-04-04 at 14:34 +1100, Paul Mackerras wrote:
> Also, rtasd isn't actually a task, it's just a function that gets run
> via schedule_delayed_work_on() and re-schedules itself each time it
> runs.  Is there any deadlock possibility in calling flush_work from a
> work function?

There used to be, but I'm not familiar with the "new" implementation of
the work queue stuff.

Cheers,
Ben.
