Return-Path: <jcrigby@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.227])
	by ozlabs.org (Postfix) with ESMTP id D161DDDE04
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 13:40:58 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so293872rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 20:40:57 -0700 (PDT)
Message-ID: <4b73d43f0806262040s7993dcb7vd8a3d05793ea8a7@mail.gmail.com>
Date: Thu, 26 Jun 2008 21:40:57 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "John Rigby" <jrigby@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: [Resend][PATCH 1/8][Version 2] MPC5121 Update MPC5121ADS device
	tree
In-Reply-To: <20080627014233.GB17621@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080625203051.4FE882F123B@rumpole.eng.lineo.com>
	<20080627014233.GB17621@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Because get_immrbase in fsl_soc.c does not work without it.

On Thu, Jun 26, 2008 at 7:42 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Wed, Jun 18, 2008 at 02:24:46PM -0600, John Rigby wrote:
>> Updated device tree for MPC5121ADS
>
> [snip]
>>       soc@80000000 {
>>               compatible = "fsl,mpc5121-immr";
>> +             device_type = "soc";
>
> I realise we still need the unwanted device_type value on the soc in
> some cases for backwards compatibility, but why are you adding it
> where it wasn't before..?
>
> --
> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _other_
>                                | _way_ _around_!
> http://www.ozlabs.org/~dgibson
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
