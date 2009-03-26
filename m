Return-Path: <timur.tabi@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id C13FCDDDA9
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 02:14:24 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g9so602313rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 08:14:23 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1236817324-24612-1-git-send-email-timur@freescale.com>
References: <1236817324-24612-1-git-send-email-timur@freescale.com>
Date: Thu, 26 Mar 2009 10:14:23 -0500
Message-ID: <ed82fe3e0903260814u1800f6a2vf067899e79198be8@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc: clean up ssi.txt, add definition for fsl,
	ssi-asynchronous
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 11, 2009 at 7:22 PM, Timur Tabi <timur@freescale.com> wrote:
> Add the definition of the fsl,ssi-asynchronous property to ssi.txt (documentation
> of the device tree bindings for the Freescale SSI device).
>
> Also tidy up the layout of ssi.txt.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>

Kumar, can you pick this up for 2.6.30?

-- 
Timur Tabi
Linux kernel developer at Freescale
