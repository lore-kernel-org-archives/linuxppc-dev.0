Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by ozlabs.org (Postfix) with ESMTP id 6C3B3DDFC5
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 01:03:32 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so989208nzf
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 08:03:31 -0700 (PDT)
Message-ID: <fa686aa40707100803s7e205da1je83f55cf30557118@mail.gmail.com>
Date: Tue, 10 Jul 2007 09:03:30 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stuart Yoder" <b08248@freescale.com>
Subject: Re: [PATCH v3][POWERPC] document ipic level/sense info
In-Reply-To: <200707101451.l6AEp9A3019214@ld0164-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200707101451.l6AEp9A3019214@ld0164-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/10/07, Stuart Yoder <b08248@freescale.com> wrote:
> document level/sense encoding info for IPIC
> interrupt controllers
>
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
> +       2 =  high to low edge sense type enabled
> +       8 =  active low level sense type enabled
> +
> +Note: other level/sense types (0,1,4, etc) are not supported.

Perfect!  :-)

Acked-by: Grant Likely <grant.likely@secretlab.ca>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
