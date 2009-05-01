Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99FEADDEE2
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 08:14:56 +1000 (EST)
Message-Id: <4A79385A-2FCF-4A5C-BD95-B2291CF5D626@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Haiying Wang <Haiying.Wang@freescale.com>
In-Reply-To: <1241206851-27749-3-git-send-email-Haiying.Wang@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 5/6 v2] net/ucc_geth: Assign six threads to Rx for UEC
Date: Fri, 1 May 2009 17:12:44 -0500
References: <1241206851-27749-1-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-2-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-3-git-send-email-Haiying.Wang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2009, at 2:40 PM, Haiying Wang wrote:

> in the case the QE has 46 SNUMs for the threads to support four UCC  
> Ethernet at
> 1000Base-T simultaneously.
>
> Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> ---
> v2 change: Add comments for the Rx threads change.
> drivers/net/ucc_geth.c |   10 +++++++++-
> 1 files changed, 9 insertions(+), 1 deletions(-)

applied to next

- k
