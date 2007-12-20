Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E068DDED5
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 02:07:50 +1100 (EST)
Date: Thu, 20 Dec 2007 14:45:32 +0000
From: Andy Whitcroft <apw@shadowen.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [RFC] Xilinx SystemACE: Add media hotplug support
Message-ID: <20071220144532.GA27885@shadowen.org>
References: <20071220062348.16448.24575.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071220062348.16448.24575.stgit@trillian.secretlab.ca>
Cc: axboe@kernel.dk, monstr@monstr.eu, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 19, 2007 at 11:23:48PM -0700, Grant Likely wrote:

> +		/* Make the sysace device 'live' */
> +		if (ace->fsm_state != ACE_FSM_STATE_INVALIDATE_MEDIA);
> +			add_disk(ace->gd);

checkpatch.pl reports the above if as suspect due to the trailing ;.
Looks wrong to me too.

WARNING: Trailing semicolon indicates no statements, indent implies
otherwise
#296: FILE: drivers/block/xsysace.c:835:
+               if (ace->fsm_state != ACE_FSM_STATE_INVALIDATE_MEDIA);
+                       add_disk(ace->gd);

-apw
