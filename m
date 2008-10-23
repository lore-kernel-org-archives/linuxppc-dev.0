Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 3987DDDE23
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 05:13:08 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3] powerpc: Specify GPIO number base for controller in DT
Date: Thu, 23 Oct 2008 20:13:00 +0200
References: <1224764850.4082.54.camel@galileo.recco.de>
	<D6AED5C1-6936-48BB-8D0F-98471C6841B0@kernel.crashing.org>
	<1224773378.4082.64.camel@galileo.recco.de>
In-Reply-To: <1224773378.4082.64.camel@galileo.recco.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810232013.00539.sr@denx.de>
Cc: Wolfgang Ocker <weo@reccoware.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 23 October 2008, Wolfgang Ocker wrote:
> The GPIOLIB allows the specification of a base gpio number for a
> controller. That is not possible using OF. Instead, free gpio numbers
> are assigned.
>
> In order to allow static, predefined gpio numbers, a base property in
> the gpio controller node specifies the first gpio number.
>
> v2, v3: added/improved description of base property in doc

These version descriptions are better placed below the "---" line. And you 
should remove the "Re: " from the subject line. Other than this:

Acked-by: Stefan Roese <sr@denx.de>

> Signed-off-by: Wolfgang Ocker <weo@reccoware.de>
> ---

Best regards,
Stefan
