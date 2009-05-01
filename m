Return-Path: <timur.tabi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 7D326DDE25
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 06:15:36 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so2100632qwe.15
	for <linuxppc-dev@ozlabs.org>; Fri, 01 May 2009 13:15:34 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1241206851-27749-1-git-send-email-Haiying.Wang@freescale.com>
References: <1241206851-27749-1-git-send-email-Haiying.Wang@freescale.com>
Date: Fri, 1 May 2009 15:15:34 -0500
Message-ID: <ed82fe3e0905011315j4678d0c4idecc8c66d288367f@mail.gmail.com>
Subject: Re: [PATCH 2/6 v2] powerpc/qe: update risc allocation for QE
From: Timur Tabi <timur@freescale.com>
To: Haiying Wang <Haiying.Wang@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 1, 2009 at 2:40 PM, Haiying Wang <Haiying.Wang@freescale.com> wrote:
> Change the RISC allocation to macros instead of enum, add function to read the
> number of risc engines from the new property "fsl,qe-num-riscs" under qe node
> in dts. Add new property "fsl,qe-num-riscs" description in qe.txt
>
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
