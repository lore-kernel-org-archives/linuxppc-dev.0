Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qW99P70C6zDq80
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2016 02:20:25 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (smtprelay0123.hostedemail.com
 [216.40.44.123])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qW99P4801z9sD5
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Mar 2016 02:20:25 +1100 (AEDT)
Date: Thu, 24 Mar 2016 11:20:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>, bsingharora@gmail.com, duwe@lst.de,
 <linux-kernel@vger.kernel.org>, kamalesh@linux.vnet.ibm.com,
 pmladek@suse.com, jeyu@redhat.com, jkosina@suse.cz,
 live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH 2/6] ftrace: Make ftrace_location_range() global
Message-ID: <20160324112019.0a61e0b3@gandalf.local.home>
In-Reply-To: <1458817445-5855-2-git-send-email-mpe@ellerman.id.au>
References: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
 <1458817445-5855-2-git-send-email-mpe@ellerman.id.au>
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

On Thu, 24 Mar 2016 22:04:01 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> In order to support live patching on powerpc we would like to call
> ftrace_location_range(), so make it global.

Do you want me to try to get this into this merge window?

-- Steve
