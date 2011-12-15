Return-Path: <jkosina@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id BD5661007D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2011 04:46:35 +1100 (EST)
Date: Thu, 15 Dec 2011 18:46:30 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH 1/3]arch:powerpc:sysdev:mpic.c Remove extra semicolon.
In-Reply-To: <4EEA2A5A.2050008@gmail.com>
Message-ID: <alpine.LNX.2.00.1112151845550.23478@pobox.suse.cz>
References: <1321893808-3721-1-git-send-email-justinmattock@gmail.com>
 <4EEA2A5A.2050008@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 15 Dec 2011, Justin P. Mattock wrote:

> what would be the status of these? should I resend/rebase to the current
> etc?..

Check linux-next, it's already there.

> 
> On 11/21/2011 08:43 AM, Justin P. Mattock wrote:
> > From: "Justin P. Mattock"<justinmattock@gmail.com>
> > 
> > The patch below removes an extra semicolon.
> > 
> > Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
> > CC: linuxppc-dev@lists.ozlabs.org
> > CC: Paul Mackerras<paulus@samba.org>
> > ---
> >   arch/powerpc/sysdev/mpic.c |    2 +-
> >   1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> > index 8c7e852..b3fa3d7 100644
> > --- a/arch/powerpc/sysdev/mpic.c
> > +++ b/arch/powerpc/sysdev/mpic.c
> > @@ -901,7 +901,7 @@ int mpic_set_irq_type(struct irq_data *d, unsigned int
> > flow_type)
> >   	if (vold != vnew)
> >   		mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI), vnew);
> > 
> > -	return IRQ_SET_MASK_OK_NOCOPY;;
> > +	return IRQ_SET_MASK_OK_NOCOPY;
> >   }
> > 
> >   void mpic_set_vector(unsigned int virq, unsigned int vector)
> 

-- 
Jiri Kosina
SUSE Labs
