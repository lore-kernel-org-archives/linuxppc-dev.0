Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id B1DF6DDF8A
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 03:11:27 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so25319anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Apr 2008 09:11:26 -0700 (PDT)
Message-ID: <fa686aa40804040911o63e2e3efg2d9a74fff082fb16@mail.gmail.com>
Date: Fri, 4 Apr 2008 10:11:26 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Bartlomiej Sieka" <tur@semihalf.com>
Subject: Re: Please pull linux-2.6-mpc52xx.git
In-Reply-To: <47F60D5D.5090402@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>
	<20080317222836.AFA66241A2@gemini.denx.de>
	<fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
	<47E938A8.9000103@semihalf.com>
	<fa686aa40803251151p457a2295w449222654be4d0d1@mail.gmail.com>
	<47F22C9A.4050501@semihalf.com> <47F60D5D.5090402@semihalf.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 4, 2008 at 5:13 AM, Bartlomiej Sieka <tur@semihalf.com> wrote:
>
> Bartlomiej Sieka wrote:
>
> > Hi Grant,
> >
> > Grant Likely wrote:
> > > I'm thinking 'optimized' defconfigs should go into a subdirectory.
> >
> > This requires a change to the top-level Makefile and shepherding this
> > change upstream. Could we perhaps try to avoid this by having optimized
> > defconfigs in the form of, for example:

I don't think changes are required to put them in a subdir:

$ mkdir arch/powerpc/configs/optimized
$ cp arch/powerpc/configs/mpc5200_defconfig
arch/powerpc/configs/optimized/lite5200_defconfig
$ make optimized/lite5200_defconfig

This works for me.

>
>  Grant,
>
>  Any thoughts on the above?

Sorry I didn't reply earlier

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
