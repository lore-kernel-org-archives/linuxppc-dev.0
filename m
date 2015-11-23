Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 876F01A009B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 12:01:48 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (smtprelay0023.hostedemail.com
 [216.40.44.23]) by ozlabs.org (Postfix) with ESMTP id 2A03A1402B6
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Nov 2015 12:01:48 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 548F928EC19
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Nov 2015 00:52:56 +0000 (UTC)
Date: Sun, 22 Nov 2015 19:52:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@ozlabs.org, "Paul
 E. McKenney" <paulmck@linux.vnet.ibm.com>, Anton Blanchard
 <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: tracing: don't trace hcalls on offline CPUs
Message-ID: <20151122195250.655a6b69@gandalf.local.home>
In-Reply-To: <1448235359.18775.1.camel@ellerman.id.au>
References: <1446145810-5383-1-git-send-email-kda@linux-powerpc.org>
 <1446545202.2801.2.camel@ellerman.id.au>
 <CAOJe8K0=J033NMh++iznar21_p4G4epAgE0wONoxZxEyFPS9VQ@mail.gmail.com>
 <CAOJe8K1q=bO5iKfnG=9ZLNvk0sREcfqNJuHNhyspe6MG4hSfHA@mail.gmail.com>
 <1448235359.18775.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 23 Nov 2015 10:35:59 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> It's mostly a tracing patch, so I'd need an ACK from Steve at least.
> 
> It would probably be best if you split it into a "tracing: .. " patch which
> adds the new macros and then a powerpc patch which uses them.

Yes please do that. I would like to throw the tracing part through my
test suite.

-- Steve
