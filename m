Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id BE0FFDDED6
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Apr 2008 20:51:33 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so397011uge.0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 02 Apr 2008 02:51:30 -0700 (PDT)
To: "John Linn" <John.Linn@xilinx.com>
Subject: Re: Virtex V5FX PPC 440 Support In Xilinx Git Tree
References: <20080401234142.41B13191804A@mail111-sin.bigfish.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 02 Apr 2008 11:51:27 +0200
In-Reply-To: <20080401234142.41B13191804A@mail111-sin.bigfish.com> (John
	Linn's message of "Tue\, 1 Apr 2008 17\:41\:40 -0600")
Message-ID: <87lk3w8u00.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: git <git@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "John" == John Linn <John.Linn@xilinx.com> writes:

 John> I pushed PowerPC 440 support to the Xilinx Git server with
 John> support for ppc arch and with powerpc arch support coming in
 John> the near future.

Neat, but why have you added arch/ppc support? It's supposed to go
away pretty much by the time the hardware gets in the hand of
developers.

-- 
Bye, Peter Korsgaard
