Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0160.hostedemail.com
 [216.40.44.160])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNVFX5vfhzDsxl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 02:46:40 +1100 (AEDT)
Date: Tue, 22 Nov 2016 10:46:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH] powerpc: split ftrace bits into a separate file
Message-ID: <20161122104634.5c28c4b8@gandalf.local.home>
In-Reply-To: <20161122154318.GA29256@naverao1-tp.localdomain>
References: <20161122095532.21062-1-naveen.n.rao@linux.vnet.ibm.com>
 <20161122094617.43d050f0@gandalf.local.home>
 <20161122154318.GA29256@naverao1-tp.localdomain>
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

On Tue, 22 Nov 2016 21:13:18 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Hi Steve,
> 
> On 2016/11/22 09:46AM, Steven Rostedt wrote:
> > On Tue, 22 Nov 2016 15:25:32 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> >   
> > > No functional changes.  
> > 
> > Should have a better change log though. Why did you do this?
> > 
> > I'm personally fine with this, as long as the powerpc maintainers are
> > too.  
> 
> Sure, thanks. Michael Ellerman wanted to split up entry_*.S:
> https://marc.info/?l=linuxppc-embedded&m=147944810526787
> 
> I probably should have added a tag to indicate the same:
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> 

Yeah, and it there should be a small blurb about cleaning up entry_*.S,
and this is just part of that clean up.

-- Steve
