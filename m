Return-Path: <groeck7@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49A5D1A003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jul 2014 02:43:58 +1000 (EST)
Received: by mail-pa0-f41.google.com with SMTP id fb1so7635184pad.14
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jul 2014 09:43:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 8 Jul 2014 09:43:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Nick Krause <xerofoify@gmail.com>
Subject: Re: Fwd: powerpc allyesconfig fix
Message-ID: <20140708164352.GA12935@roeck-us.net>
References: <1404795849-25609-1-git-send-email-xerofoify@gmail.com>
 <20140708160417.47fb4d7c@canb.auug.org.au>
 <CAPDOMVitjYMkoLAbwf6oBJg+fpFdKLi+S4hTm6opD27DMC1NDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPDOMVitjYMkoLAbwf6oBJg+fpFdKLi+S4hTm6opD27DMC1NDw@mail.gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, mahesh <mahesh@linux.vnet.ibm.com>,
 Alexander Graf <agraf@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Michael Ellerman <michael@ellerman.id.au>, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 08, 2014 at 12:35:27PM -0400, Nick Krause wrote:
> From: Stephen Rothwell wrote on Tue, Jul 8, 2014 at 2:04 AM
> Subject: Re: powerpc allyesconfig fix
> 
> Hi Nicholas,
> 
> On Tue,  8 Jul 2014 01:04:09 -0400 Nicholas Krause <xerofoify@gmail.com> wrote:
> >
> > powerpc:allmodconfig has been failing for some time with the following
> > error.
> 
> This patch has already bee submitted directly by Guenter, however for
> future reference:  when you submit someone else's patch, you should
> include a From line as the first line of the email body containing their
> email address and you should include a Signed-off-by line from yourself.
> 
> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> 
> 
> Hey Stephen,
> Thanks for the heads up on submitting other people's patches. It would
> be great if you can push this up into Linus's tree
> for the next developer release.

Ben already mentioned that he would pick it up.

Guenter
