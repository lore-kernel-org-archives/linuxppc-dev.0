Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.245])
	by ozlabs.org (Postfix) with ESMTP id E35DEDE197
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 01:44:43 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so3416579agc.0
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Jun 2008 08:44:42 -0700 (PDT)
Message-ID: <fa686aa40806060844m1cb872ddn2aef4d05d4c8fd80@mail.gmail.com>
Date: Fri, 6 Jun 2008 09:44:39 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: Default flats for running dtc from kernel build
In-Reply-To: <0E974259-7988-4E3F-81F6-3FDEA01BAC9A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080606143347.B35CC247FE@gemini.denx.de>
	<A005B9E2-9A1D-4190-AB00-A7C880E4DBDB@kernel.crashing.org>
	<1212766264.6788.4.camel@ld0161-tx32>
	<0E974259-7988-4E3F-81F6-3FDEA01BAC9A@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 6, 2008 at 9:42 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> Yeah, I think the -R isn't need either.
>
> So maybe:
>
> DTS_FLAGS       ?= -P 0x1000
>
> 1k seems like more than enough default padding.

Good by me.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
