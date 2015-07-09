Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59E661A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 17:07:15 +1000 (AEST)
Message-ID: <1436425635.21344.2.camel@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/powernv: Fix race in updating core_idle_state
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Thu, 09 Jul 2015 17:07:15 +1000
In-Reply-To: <1436416901.28537.11.camel@axtens.net>
References: <1436213363-18419-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1436228558.3341.1.camel@ellerman.id.au>
 <1436416901.28537.11.camel@axtens.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-07-09 at 14:41 +1000, Daniel Axtens wrote:
> > I recommend creating an alias or script that does:
> > 
> > $ git log --pretty=fixes -n 1 $commit | xclip
> > 
> 
> FWIW, having finally got around to doing this, I found I first needed
> the following snippet in ~/.gitconfig from
> https://www.kernel.org/doc/Documentation/SubmittingPatches
> 
> 
> 	[core]
> 		abbrev = 12
> 	[pretty]
> 		fixes = Fixes: %h (\"%s\")
> 
> Otherwise git doesn't know what the pretty format is.

Oh right, yeah. Doesn't everyone have my dotfiles!?

cheers
