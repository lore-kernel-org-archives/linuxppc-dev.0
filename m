Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id BD79ADDF81
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 04:55:05 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so2412611uge
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 11:55:04 -0700 (PDT)
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 12/12] Uartlite: Let the console be initialized earlier
References: <20071002021334.9579.68179.stgit@trillian.cg.shawcable.net>
	<20071002021609.9579.5233.stgit@trillian.cg.shawcable.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 02 Oct 2007 20:54:56 +0200
In-Reply-To: <20071002021609.9579.5233.stgit@trillian.cg.shawcable.net> (Grant
	Likely's message of "Mon\, 01 Oct 2007 20\:16\:09 -0600")
Message-ID: <87ir5pz6rj.fsf@macbook.be.48ers.dk>
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

 Grant> From: Grant Likely <grant.likely@secretlab.ca> By configuring
 Grant> it earlier we get console output sooner which is helpful for
 Grant> debugging when the kernel crashes before the serial drivers
 Grant> are initialized.

 Grant> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
