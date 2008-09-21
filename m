Return-Path: <jacmet@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.25])
	by ozlabs.org (Postfix) with ESMTP id 7673EDDEE1
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 05:30:10 +1000 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so325044eyi.15
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Sep 2008 12:30:08 -0700 (PDT)
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: implement support for MPC8349-compatible SOC
	GPIOs
References: <20080917175820.GA22539@oksana.dev.rtsoft.ru>
	<871vziwoxj.fsf@macbook.be.48ers.dk>
	<20080918112020.GA11584@oksana.dev.rtsoft.ru>
	<87ej3gyxv0.fsf@macbook.be.48ers.dk>
	<20080919153325.GA548@oksana.dev.rtsoft.ru>
	<1BA571BA-BA43-4C18-9CBF-0F1461E6734E@kernel.crashing.org>
	<20080919181258.GA14093@oksana.dev.rtsoft.ru>
	<ABD97D30-4503-4A5E-A04B-2D644BF31124@kernel.crashing.org>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Sun, 21 Sep 2008 21:30:05 +0200
In-Reply-To: <ABD97D30-4503-4A5E-A04B-2D644BF31124@kernel.crashing.org> (Kumar
	Gala's message of "Fri\, 19 Sep 2008 13\:46\:49 -0500")
Message-ID: <871vzdz48y.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Kumar" == Kumar Gala <galak@kernel.crashing.org> writes:

Hi,

 Kumar> This way the compatiable binding in the code just lists something like
 Kumar> "fsl,mpc8349-gpio", "fsl,mpc8610-gpio", "fsl,mpc8572-gpio".

 Kumar> Does that make sense?

Yes, sounds fine - I'll adapt the patch and resend.

-- 
Bye, Peter Korsgaard
