Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40g59m3jQ2zF1n3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 13:50:36 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id a13-v6so20564420pgu.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 20:50:36 -0700 (PDT)
Date: Tue, 8 May 2018 13:50:19 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
 andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com, corbet@lwn.net
Subject: Re: [PATCH v2 6/7] ocxl: Add an IOCTL so userspace knows what CPU
 features are available
Message-ID: <20180508135019.3e08d57a@roar.ozlabs.ibm.com>
In-Reply-To: <1525740115.7796.46.camel@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-7-alastair@au1.ibm.com>
 <eec7dceb-0b25-8644-7f32-3700c3c4ed46@linux.ibm.com>
 <1525740115.7796.46.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 08 May 2018 10:41:55 +1000
"Alastair D'Silva" <alastair@au1.ibm.com> wrote:

> On Mon, 2018-05-07 at 20:14 +0200, Frederic Barrat wrote:
> > 
> > Le 18/04/2018 à 03:08, Alastair D'Silva a écrit :  
> > > From: Alastair D'Silva <alastair@d-silva.org>
> > > 
> > > In order for a userspace AFU driver to call the Power9 specific
> > > OCXL_IOCTL_ENABLE_P9_WAIT, it needs to verify that it can actually
> > > make that call.
> > > 
> > > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > > ---
> > >   Documentation/accelerators/ocxl.rst |  1 -
> > >   drivers/misc/ocxl/file.c            | 25
> > > +++++++++++++++++++++++++
> > >   include/uapi/misc/ocxl.h            |  4 ++++
> > >   3 files changed, 29 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/accelerators/ocxl.rst
> > > b/Documentation/accelerators/ocxl.rst
> > > index ddcc58d01cfb..7904adcc07fd 100644
> > > --- a/Documentation/accelerators/ocxl.rst
> > > +++ b/Documentation/accelerators/ocxl.rst
> > > @@ -157,7 +157,6 @@ OCXL_IOCTL_GET_METADATA:
> > >     Obtains configuration information from the card, such at the
> > > size of
> > >     MMIO areas, the AFU version, and the PASID for the current
> > > context.
> > > 
> > > -  
> > 
> > 
> > Intended?
> > 
> > Other than that,
> > Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> >   
> 
> Nope, I'll fix that, thanks.
> 

Just to be clear, this is for OCXL features. I would just make that
explicit in the title (s/CPU/OCXL).

Thanks,
Nick
