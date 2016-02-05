Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB2DE1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 01:36:54 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (smtprelay0198.hostedemail.com
 [216.40.44.198])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 45E1F140BAD
 for <linuxppc-dev@ozlabs.org>; Sat,  6 Feb 2016 01:36:53 +1100 (AEDT)
Date: Fri, 5 Feb 2016 09:36:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 2/2] powerpc: tracing: don't trace hcalls on offline
 CPUs
Message-ID: <20160205093647.79ca2f70@gandalf.local.home>
In-Reply-To: <CAOJe8K2Ahh-y95BmpsP+d2P9ysUsyo5CnhPOXymEJzjFwkR=7Q@mail.gmail.com>
References: <1450124286-4822-1-git-send-email-kda@linux-powerpc.org>
 <1450124286-4822-2-git-send-email-kda@linux-powerpc.org>
 <1452599615.20985.2.camel@ellerman.id.au>
 <CAOJe8K2iVOy9=Ds09_ePct3xR6qCH0U4XoKW-qP_TNEMe8GAmQ@mail.gmail.com>
 <CAOJe8K2Ahh-y95BmpsP+d2P9ysUsyo5CnhPOXymEJzjFwkR=7Q@mail.gmail.com>
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

On Fri, 5 Feb 2016 14:20:17 +0300
Denis Kirjanov <kda@linux-powerpc.org> wrote:

> >>> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>  
> >
> > Hi Steven,
> >
> > please apply with Michael's acked-by tag.  
> 
> ping
> 

Actually, can you take this through the ppc tree? The
TRACE_EVENT_FN_COND is already in mainline.

You can add my:

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
