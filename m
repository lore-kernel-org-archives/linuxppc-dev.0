Return-Path: <linuxppcleo@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 83B7167D29
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 02:38:56 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id h2so854211ugf
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 09:38:54 -0700 (PDT)
Message-ID: <a0bc9bf80607140921y5d11bf37r3f18e2dbdd03b017@mail.gmail.com>
Date: Sat, 15 Jul 2006 00:21:11 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
In-Reply-To: <B8AB8BA6-500C-43AC-B6E7-A76CA598A429@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <44B7857A.2060101@freescale.com>
	<B8AB8BA6-500C-43AC-B6E7-A76CA598A429@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/14/06, Kumar Gala <galak@kernel.crashing.org> wrote:
> Nack, my expectation is this is all setup by the boot loader.

That's a good wish. ;)  However, USB is not required by bootloader. So
it is not likely to be initialized there.  And if we put it in
bootloader, it will be hard to change the mode(MPH/DR), which requires
a re-burn of bootloader.  It's better that we make sure it's correctly
configured here.
>
> - k
>
> On Jul 14, 2006, at 6:52 AM, Li Yang wrote:
>
> > This adds USB platform support to MPC8349 PB.  It works with the
> > fsl_usb2_udc driver.
> >
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
