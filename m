Return-Path: <jcrigby@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 6756E67F75
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 03:17:31 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id x4so975794nfb
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 10:17:29 -0700 (PDT)
Message-ID: <4b73d43f0610261017s38cdc78fn23ea07113bf8c0fc@mail.gmail.com>
Date: Thu, 26 Oct 2006 11:17:27 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "Nicolas DET" <nd@bplan-gmbh.de>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
In-Reply-To: <453FB582.20802@bplan-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <453FB582.20802@bplan-gmbh.de>
Cc: akpm@osdl.org, sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> * mpc5k2_bestcomm.c (& helpers): I've been in contact with others people
> using bestcomm and please to see the development was still active. I'm
> already using latest code on my board but this is not include in this
> patch. Indeed, it needs some changes for ARCH=powerpc. Moreover, we have
> a different approach for the tasks. I'll be pleased to work with the
> bestcomm folks.
>

So you preload the bestcomm task code in your boot loader?  Do those
of us using other bootloaders still have the option of loading the
task code later in linux?

What api are you using?  Sylvain's proposed one based on Dale's with
some additions from me?  Or have you come up with your own?
