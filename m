Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id DE065DDFA9
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 04:51:19 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so2411933uge
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 11:51:17 -0700 (PDT)
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Uartlite: Revert register io access changes
References: <20071002164702.24707.79414.stgit@trillian.cg.shawcable.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 02 Oct 2007 20:50:54 +0200
In-Reply-To: <20071002164702.24707.79414.stgit@trillian.cg.shawcable.net>
	(Grant Likely's message of "Tue\, 02 Oct 2007 10\:47\:02 -0600")
Message-ID: <87zlz1z6y9.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

 Grant> From: Grant Likely <grant.likely@secretlab.ca>
 Grant> Reverts commit 58205d2b1256a32c9e8b02587f8ef3cdcf1eb8bd

 Grant> This driver is used by devices other than the xilinx
 Grant> opb-uartlite which depend on bytewise access to the registers.
 Grant> The change to 32 bit access does not work on these devices.

 Grant> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
