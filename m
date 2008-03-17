Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 63A22DDF16
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 06:19:46 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b2so1210484ana.81
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 12:19:45 -0700 (PDT)
Message-ID: <fa686aa40803171219s7135a0f8n91bcd20329a94637@mail.gmail.com>
Date: Mon, 17 Mar 2008 13:19:44 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Bartlomiej Sieka" <tur@semihalf.com>
Subject: Re: Please pull linux-2.6-mpc52xx.git
In-Reply-To: <47DE94F4.90804@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40802232335k24729c0fm6f643d06cccaf087@mail.gmail.com>
	<47DE94F4.90804@semihalf.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 9:57 AM, Bartlomiej Sieka <tur@semihalf.com> wrote:
> Grant Likely wrote:
>  > Paul, here is a bug fix that needs to go in for 2.6.25.
>
>  Hi Grant,
>
>  What is the status of the various MPC5200-related patches (support for
>  TQM5200, CM5200 and Motion-PRO boards, few drivers, etc) posted some
>  time ago by Marian Balakowicz? There's been some comments to the patches
>  on the list, which were addressed and no further discussion occurred, so
>  we were hoping that the changes would go upstream (in 2.6.25). I can see
>  that the .dts files for those boards are in the mainline already, but I
>  see no trace of for example _defconfig files -- could you shed some
>  light on this?

Yes, the separate dts files have been dropped in preference for a
single mpc5200_defconfig for all 5200 boards.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
