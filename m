Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by ozlabs.org (Postfix) with ESMTP id 23099DDE44
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 08:48:11 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so783537nzf
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Jul 2007 15:48:10 -0700 (PDT)
Message-ID: <fa686aa40707091548h5182d6d0r900afc1f35d4f80f@mail.gmail.com>
Date: Mon, 9 Jul 2007 16:48:09 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stuart Yoder" <b08248@freescale.com>
Subject: Re: [PATCH v2][POWERPC] document ipic level/sense info
In-Reply-To: <200707092235.l69MZRnh015324@ld0164-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200707092235.l69MZRnh015324@ld0164-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/9/07, Stuart Yoder <b08248@freescale.com> wrote:
>
> document level and sense information for the Freescale
> IPIC interrupt controller
>
> +Sense and level information follows the Linux convention
> +(specified in include/linux/interrupt.h) and should be encoded
> +as follows:
> +
> +       2 =  high to low edge sensitive type enabled
> +       8 =  active low level sensitive type enabled
> +

... but it is probably worthwhile commentting that sense types 1 & 4
are not supported; just to fill in the obvious gaps.  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
