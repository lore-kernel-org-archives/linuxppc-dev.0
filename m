Return-Path: <kumar.gala@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 4EEEF67A6E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 12:11:04 +1100 (EST)
In-Reply-To: <0.20050322_000905.tnt@patchsend.246tNt.com>
References: <0.20050322_000905.tnt@patchsend.246tNt.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <556f5ce38ca914dce63ca24277af4b3e@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 21 Mar 2005 19:11:04 -0600
To: "Sylvain Munaut" <tnt@246tNt.com>
Cc: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 0/6] [RFC] Change MPC52xx to platform bus / ppc_sys model
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sylvain,

Took a quick glance at the patches and they look good.  Do you have a=20
bk tree available with all these changes in them?

I think a might have a few minor comments, but might be easier to see=20
the bk tree.

- kumar

On Mar 21, 2005, at 5:06 PM, Sylvain Munaut wrote:

> Hi all,
>
> This series of patch changes all the MPC52xx related code
>  to use platform bus and ppc_sys instead of OCP. It's
>  divided in several patches that represents "steps" in
>  the conversion. However the intermediate states might
>  not be functionnal.
>
> This is the first try, comments and suggestions are
>  welcomed.
>
>
>
> =A0=A0=A0=A0=A0=A0=A0 Sylvain
>  _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
