Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.227])
	by ozlabs.org (Postfix) with ESMTP id E7643DE8E4
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 05:51:44 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so3167029wxd.15
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 11:51:42 -0700 (PDT)
Message-ID: <fa686aa40803251151p457a2295w449222654be4d0d1@mail.gmail.com>
Date: Tue, 25 Mar 2008 12:51:41 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Bartlomiej Sieka" <tur@semihalf.com>
Subject: Re: Please pull linux-2.6-mpc52xx.git
In-Reply-To: <47E938A8.9000103@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>
	<20080317222836.AFA66241A2@gemini.denx.de>
	<fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
	<47E938A8.9000103@semihalf.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 25, 2008 at 11:38 AM, Bartlomiej Sieka <tur@semihalf.com> wrote:
> Grant Likely wrote:
>  > The one part that I have a really strong opinion on is that there
>  > should be a full featured mpc5200 defconfig for build testing.  Beyond
>  > that (and if ojn can also be appeased) I can probably be convinced.  :-)
>
>  Hi Grant,
>
>  How to deal with a situation where I need a particular PHY driver from
>  libphy compiled in the kernel for one of the MPC5200 boards? Adding it
>  to mpc5200_defconfig doesn't seem like a right thing to do.

Why not?  mpc5200_defconfig is all about compile and runtime testing
on many platforms to make sure drivers play well together.  I have no
problem adding more drivers to the mpc5200 defconfig.  (In fact, I
encourage it).

>  How to
>  convince you (and appease ojn) to accept a patch that adds a
>  board-specific defconfig that only slightly differs from
>  mpc5200_defconfig? :)

I'm thinking 'optimized' defconfigs should go into a subdirectory.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
