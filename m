Return-Path: <timur.tabi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 17BBFDDE25
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 06:17:09 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so2101140qwe.15
	for <linuxppc-dev@ozlabs.org>; Fri, 01 May 2009 13:17:08 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1241206851-27749-3-git-send-email-Haiying.Wang@freescale.com>
References: <1241206851-27749-1-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-2-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-3-git-send-email-Haiying.Wang@freescale.com>
Date: Fri, 1 May 2009 15:17:08 -0500
Message-ID: <ed82fe3e0905011317t4f3f1e63qb733b89da9685e79@mail.gmail.com>
Subject: Re: [PATCH 5/6 v2] net/ucc_geth: Assign six threads to Rx for UEC
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
> in the case the QE has 46 SNUMs for the threads to support four UCC Ethernet at
> 1000Base-T simultaneously.
>
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>

Acked-by: Timur Tabi <timur@freescale.com>

FYI, this should have been cross-posted to the netdev mailing list.

-- 
Timur Tabi
Linux kernel developer at Freescale
