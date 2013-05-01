Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 46CA82C00D3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 May 2013 15:10:36 +1000 (EST)
Date: Wed, 1 May 2013 06:10:14 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: linux-next: manual merge of the vfs tree with the powerpc tree
Message-ID: <20130501051014.GA11630@ZenIV.linux.org.uk>
References: <20130501120636.0e54681b2dfb7ebe6aeb27c4@canb.auug.org.au>
 <5180A1AD.4060409@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5180A1AD.4060409@linux.vnet.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 01, 2013 at 10:31:33AM +0530, Vasant Hegde wrote:
> On 05/01/2013 07:36 AM, Stephen Rothwell wrote:
> >Hi Al,
> >
> >Today's linux-next merge of the vfs tree got a conflict in
> >arch/powerpc/kernel/rtas_flash.c between commit fb4696c39573
> >("powerpc/rtas_flash: Fix bad memory access") from the powerpc tree and
> >commits ad18a364f186 ("powerpc/rtas_flash: Free kmem upon module exit")
> >and 2352ad01409d ("ppc: Clean up rtas_flash driver somewhat") from the
> >vfs tree.
> >
> 
> Stephen,
> 
> As Ben mentioned earlier, there are outstanding comments from me which
> needs to be addressed by Dave, before its merged.

What the hell?  Your fixes *are* folded into that commit and according to
Ben it passes testing; is there anything still missing?
