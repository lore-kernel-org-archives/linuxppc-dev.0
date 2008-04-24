Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id 484DEDDEF5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 11:09:22 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so3376460pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Apr 2008 18:09:20 -0700 (PDT)
Subject: Re: simpleboot
From: Josh Boyer <jwboyer@gmail.com>
To: "David H. Lynch Jr." <dhlii@picocomputing.net>
In-Reply-To: <480F917F.8040809@picocomputing.net>
References: <480F8148.8090906@picocomputing.net>
	<fa686aa40804231149j344a4cc5iaf15ac12828146f7@mail.gmail.com>
	<480F917F.8040809@picocomputing.net>
Content-Type: text/plain
Date: Wed, 23 Apr 2008 20:09:17 -0500
Message-Id: <1208999357.2946.6.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2008-04-23 at 15:43 -0400, David H. Lynch Jr. wrote:
> Grant Likely wrote:
> > make simpleImage.<boardname>
> > - or -
> > make simpleImage.initrd.<boardname>
> >
> > The makefile will use arch/powerpc/boot/dts/<boardname>.dts for the device tree.
>     Thanks, I suspected most of that. But I have not see simpleboot in
> Linus's tree yet,
>     so I have to back port the patch from the paulus tree and that makes
> it harder to just try it.

simpleboot is in Linus' tree now.  It went in with the first pull
request paulus sent for .26.

I don't understand that comment anyway though.  If you're working with a
PowerPC board, why aren't you using the powerpc tree (paulus') to begin
with?  "Backporting" pieces of it to some other tree seems to be a waste
of time to me...

josh
