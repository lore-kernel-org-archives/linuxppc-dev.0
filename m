Return-Path: <paul.gortmaker@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 7833BDE1FD
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 11:57:02 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 3so1314052ywj.39
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 18:57:00 -0700 (PDT)
Message-ID: <7d1d9c250804151857x65cf14cfxe6dc5696505631c7@mail.gmail.com>
Date: Tue, 15 Apr 2008 21:57:00 -0400
From: "Paul Gortmaker" <paul.gortmaker@gmail.com>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH v2.6.26 0/2] Dynamic TBIPA for gianfar
In-Reply-To: <18437.18289.944128.351533@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1208276601-16964-1-git-send-email-paul.gortmaker@windriver.com>
	<18437.18289.944128.351533@cargo.ozlabs.ibm.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 15, 2008 at 8:25 PM, Paul Mackerras <paulus@samba.org> wrote:
> Paul Gortmaker writes:
>
>  > This is the resend of the two patches as per Andy's request for v2.6.26
>  > that allow boards with a PHY at the end of the bus to function, by having
>  > the TBIPA set dynamically.  The 1st patch factors out some of the PHY
>  > probe code so it can be recycled by the TBIPA probe, and the second patch
>  > implements the dynamic probe itself.
>
>  I notice that these two patches only touch drivers/net and
>  include/linux.  If you want these to go upstream into Linus' tree, you
>  will need to send them to Jeff Garzik and the netdev list.  Posting
>  them to the linuxppc-dev list is fine for getting them reviewed but
>  isn't a path to upstream.

Yep, they have already been sent to Jeff/netdev earlier today as well.
I'd inadvertently left them off the CC but Andy reminded me already.

Thanks,
Paul.
>
>
>
>  Paul.
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
