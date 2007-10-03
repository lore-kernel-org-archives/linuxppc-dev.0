Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 1E2A9DDE9A
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 01:56:57 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so178577uge
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Oct 2007 08:56:56 -0700 (PDT)
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] fsl_spi devices should use mode "cpu" or "qe"
References: <87przwxkzf.fsf@macbook.be.48ers.dk>
	<085BE1E4-945F-4690-9DFC-627F242831A6@kernel.crashing.org>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 03 Oct 2007 17:56:48 +0200
In-Reply-To: <085BE1E4-945F-4690-9DFC-627F242831A6@kernel.crashing.org> (Kumar
	Gala's message of "Wed\, 3 Oct 2007 10\:51\:31 -0500")
Message-ID: <87d4vwxkcf.fsf@macbook.be.48ers.dk>
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

>>>>> "Kumar" == Kumar Gala <galak@kernel.crashing.org> writes:

 Kumar> On Oct 3, 2007, at 10:43 AM, Peter Korsgaard wrote:

 >> According to booting-without-of.txt, fsl_spi mode should be either
 >> "cpu" or "qe", not "cpu-qe".
 >> 
 >> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

 Kumar> I think we should update the doc instead of the code here. Thoughts?

Same for me, but qe is shorter..

-- 
Bye, Peter Korsgaard
