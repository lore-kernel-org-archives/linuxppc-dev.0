Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHnf23bJ7zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 23:04:10 +1100 (AEDT)
Date: Thu, 19 Oct 2017 14:04:06 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, Jarkko Sakkinen
 <jarkko.sakkinen@linux.intel.com>, linux-integrity@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Alexander Steffen <Alexander.Steffen@infineon.com>, Nayna Jain
 <nayna@linux.vnet.ibm.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jerry Snitselaar <jsnitsel@redhat.com>, Jason
 Gunthorpe <jgunthorpe@obsidianresearch.com>, Julia Lawall
 <julia.lawall@lip6.fr>, Corentin Labbe <clabbe.montjoie@gmail.com>, Kenneth
 Goldman <kgold@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Peter =?UTF-8?B?SMO8d2U=?= <PeterHuewe@gmx.de>, Mimi Zohar
 <zohar@linux.vnet.ibm.com>
Subject: Re: char/tpm: Improve a size determination in nine functions
Message-ID: <20171019140406.046d2714@kitsune.suse.cz>
In-Reply-To: <1508349793.16112.507.camel@linux.intel.com>
References: <1508238182.16112.475.camel@linux.intel.com>
 <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
 <1508244757.4234.60.camel@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1710171456360.5035@hadrien>
 <1508253453.4234.81.camel@linux.vnet.ibm.com>
 <9689f036-ba9f-d23b-cf89-c289bc308771@users.sourceforge.net>
 <20171018145735.lpzwakatsty7emlw@linux.intel.com>
 <351cf78a-14f6-c6e7-2902-048e7dc57a14@users.sourceforge.net>
 <20171018155946.e7ga7jyex6eia252@linux.intel.com>
 <55d76224-3019-6614-70ce-ba260bbcd54f@users.sourceforge.net>
 <20171018171858.3lcfr2kcp53fngwv@linux.intel.com>
 <e9638486-7e59-1c5a-87ae-ca0f1fbbd021@users.sourceforge.net>
 <1508349793.16112.507.camel@linux.intel.com>
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

On Wed, 18 Oct 2017 21:03:13 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, 2017-10-18 at 19:48 +0200, SF Markus Elfring wrote:
> > > For 1/4 and 2/4: explain why the message can be omitted.  
> 
> > > That's all.  
> > 
> > I assume that there might be also some communication challenges
> > involved.
> > 
> >   
> > > 3/4: definitive NAK, too much noise compared to value.  
> > 
> > I tried to reduce deviations from the Linux coding style again.
> > You do not like such an attempt for this software area so far.  
> 
> The problem here in a time line or what comes first. Definitely, you
> are trying to fix the code which _is_ upstream vs. the code which
> _might be_ upstream (exception is drivers/staging).
> 
> Why didn't you listen to what people are telling you?
> 
> Why are you spending too much time on little sense crap instead of
> doing real fixes?
> 

People are free to spend their time on what they like.

Even if no commit of this series lands in mainline it has been useful
to clarify what is preferred style and what is useful fix.

Thanks

Michal
