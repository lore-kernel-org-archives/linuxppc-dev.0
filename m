Return-Path: <jikos@kernel.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qW9Fm4f22zDq80
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2016 02:24:12 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qW9Fm1YJYz9sBm
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Mar 2016 02:24:12 +1100 (AEDT)
Date: Thu, 24 Mar 2016 16:24:06 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 bsingharora@gmail.com, duwe@lst.de, linux-kernel@vger.kernel.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 2/6] ftrace: Make ftrace_location_range() global
In-Reply-To: <20160324112019.0a61e0b3@gandalf.local.home>
Message-ID: <alpine.LNX.2.00.1603241623070.3656@cbobk.fhfr.pm>
References: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
 <1458817445-5855-2-git-send-email-mpe@ellerman.id.au>
 <20160324112019.0a61e0b3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 24 Mar 2016, Steven Rostedt wrote:

> > In order to support live patching on powerpc we would like to call
> > ftrace_location_range(), so make it global.
> 
> Do you want me to try to get this into this merge window?

I don't think that's necessary. The dependency (rest of livepatching bits 
for ppc64le) will not go in before 4.7 merge window anyway.

Thanks,

-- 
Jiri Kosina
SUSE Labs
