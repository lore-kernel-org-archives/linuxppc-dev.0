Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 0F305DDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 17:10:23 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so75649ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 00:10:21 -0700 (PDT)
Message-ID: <528646bc0704170010t6dc12af4n91f8bbeff15f6a8@mail.gmail.com>
Date: Tue, 17 Apr 2007 01:10:21 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH 4/5] mpc52xx suspend: deep-sleep
In-Reply-To: <20070417070513.GL18236@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104307.GE22215@moe.telargo.com>
	<528646bc0703230858h237237c2t5b7bedca6e42cddd@mail.gmail.com>
	<20070404073755.GE18236@moe.telargo.com>
	<528646bc0704152240u60bf24dbx6a1ca8dd15aaaf53@mail.gmail.com>
	<20070417070513.GL18236@moe.telargo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/17/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> Implement deep-sleep on MPC52xx.
> SDRAM is put into self-refresh with help of SRAM code
> (alternatives would be code in FLASH, I-cache).
> Interrupt code must also not be in SDRAM, so put it
> in I-cache.
> MPC52xx core is static, so contents will remain intact even
> with clocks turned off.
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
