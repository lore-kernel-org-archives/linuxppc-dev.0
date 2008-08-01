Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 2AE3DDE620
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 03:49:36 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so214914anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 01 Aug 2008 10:49:34 -0700 (PDT)
Subject: Re: [PATCH 10/10] mtd: remove code associated with !CONFIG_PPC_MERGE
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1217609060-6381-11-git-send-email-galak@kernel.crashing.org>
References: <1217609060-6381-1-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-2-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-3-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-4-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-5-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-6-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-7-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-8-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-9-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-10-git-send-email-galak@kernel.crashing.org>
	<1217609060-6381-11-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 01 Aug 2008 13:49:30 -0400
Message-Id: <1217612970.2328.8.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-08-01 at 11:44 -0500, Kumar Gala wrote:
> Now that arch/ppc is gone we don't need CONFIG_PPC_MERGE anymore
> remove the dead code associated with !CONFIG_PPC_MERGE.
> 
> The mtd maps should be using the OF based mechanism.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
