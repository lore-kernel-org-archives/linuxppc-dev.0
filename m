Return-Path: <jacmet@sunsite.dk>
Received: from europa.telenet-ops.be (europa.telenet-ops.be [195.130.137.75])
	by ozlabs.org (Postfix) with ESMTP id 738EB68A1F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jan 2006 05:39:18 +1100 (EST)
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 03/10] Migrate Xilinx Vertex support from the OCP bus to
	the platfom bus.
References: <11367955801988-git-send-email-grant.likely@secretlab.ca>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Fri, 13 Jan 2006 19:20:47 +0100
In-Reply-To: <11367955801988-git-send-email-grant.likely@secretlab.ca> (grant
	likely's message of "Mon, 9 Jan 2006 01:33:00 -0700")
Message-ID: <87lkxkq9a8.fsf@48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: glikely@gmail.com, dhlii@dlasys.net, gnathita@gmail.com,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "grant" == grant likely <grant.likely@secretlab.ca> writes:

 grant> +#else
 grant> +  /* Add other board xparameter includes here before the #else */
 grant> +  #error No *_xparameters.h file included
 grant> +#endif

Nitpit, but this should be #error No xparameters_*.h file included.

-- 
Bye, Peter Korsgaard
