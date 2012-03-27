Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
 [209.85.213.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 85D03B6F98
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 01:09:31 +1100 (EST)
Received: by yenl1 with SMTP id l1so4898133yen.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2012 07:09:24 -0700 (PDT)
Date: Tue, 27 Mar 2012 07:09:20 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc+sparc/vio: Modernize driver registration
Message-ID: <20120327140920.GB25109@kroah.com>
References: <1332824790.2882.51.camel@pasglop>
 <20120327.015316.1552473998755517441.davem@davemloft.net>
 <1332831027.2882.55.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332831027.2882.55.camel@pasglop>
Cc: key@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 27, 2012 at 05:50:27PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2012-03-27 at 01:53 -0400, David Miller wrote:
> > From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Date: Tue, 27 Mar 2012 16:06:30 +1100
> > 
> > > This makes vio_register_driver() get the module owner & name at compile
> > > time like PCI drivers do, and adds a name pointer directly in struct
> > > vio_driver to avoid having to explicitly initialize the embedded
> > > struct device.
> > > 
> > > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > 
> > Acked-by: David S. Miller <davem@davemloft.net>
> > --
> 
> Greg, do you want to carry this or should I ? In the later case, I'd
> rather send it to Linus now than having it hanging around til the next
> merge window :-)

Feel free to send it now, it looks good to me:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
