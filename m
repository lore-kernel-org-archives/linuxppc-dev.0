Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 88B7B1007D2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jan 2012 19:25:22 +1100 (EST)
Received: by iaae16 with SMTP id e16so28027779iaa.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jan 2012 00:25:19 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Mon, 2 Jan 2012 01:25:14 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next: build failure after merge of the final tree (powerpc
 related)
Message-ID: <20120102082514.GG18381@ponder.secretlab.ca>
References: <20111228194949.ff20a609745e816c266f7d91@canb.auug.org.au>
 <1325068334.6632.43.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325068334.6632.43.camel@pasglop>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 28, 2011 at 09:32:14PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2011-12-28 at 19:49 +1100, Stephen Rothwell wrote:
> > Hi ,
> > 
> > After merging the final tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> > 
> > kernel/built-in.o: In function `irq_dispose_mapping':
> > (.opd+0x159f0): multiple definition of `irq_dispose_mapping'
> > arch/powerpc/kernel/built-in.o:(.opd+0x960): first defined here
> > kernel/built-in.o: In function `irq_create_of_mapping':
> > (.opd+0x15a20): multiple definition of `irq_create_of_mapping'
> > arch/powerpc/kernel/built-in.o:(.opd+0x9a8): first defined here
> > kernel/built-in.o: In function `.irq_create_of_mapping':
> > (.text+0x147030): multiple definition of `.irq_create_of_mapping'
> > arch/powerpc/kernel/built-in.o:(.text+0x9de0): first defined here
> > kernel/built-in.o: In function `.irq_dispose_mapping':
> > (.text+0x146f4c): multiple definition of `.irq_dispose_mapping'
> > arch/powerpc/kernel/built-in.o:(.text+0x9684): first defined here
> > 
> > I am not sure what caused this. And have just left it broken.
> 
> Grant, is your irq remapper misbehaving ?

Hmmmm, that's odd.  I've not touched it.  I'll investigate.
