Return-Path: <jacmet@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.189])
	by ozlabs.org (Postfix) with ESMTP id 159A3DDF8D
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 04:48:10 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so4743283fkz
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 11:48:09 -0700 (PDT)
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2 7/7] Uartlite: Let the console be initialized earlier
References: <20070930224117.1871.87164.stgit@trillian.cg.shawcable.net>
	<20070930224215.1871.60933.stgit@trillian.cg.shawcable.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 02 Oct 2007 20:48:00 +0200
In-Reply-To: <20070930224215.1871.60933.stgit@trillian.cg.shawcable.net>
	(Grant Likely's message of "Sun\, 30 Sep 2007 16\:42\:16 -0600")
Message-ID: <878x6l1hgf.fsf@macbook.be.48ers.dk>
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
