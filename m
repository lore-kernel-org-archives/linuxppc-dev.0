Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5EED3DE512
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 01:29:42 +1100 (EST)
In-Reply-To: <20080325065158.6c299e05@zod.rchland.ibm.com>
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
	<20080301174825.57715d46@zod.rchland.ibm.com>
	<18407.37606.990271.551578@cargo.ozlabs.ibm.com>
	<20080325004753.5885ede9@lappy.seanm.ca>
	<20080325065158.6c299e05@zod.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3eeaa93e1376004ec581005f9da2b2ef@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RESEND] [PATCH 1/2 v2] [OF] Add of_device_is_available function
Date: Wed, 26 Mar 2008 15:25:33 +0100
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> We really want just "okay" and "ok".  Look for a version 3 of the patch
> that fixes it later today.

You might want to put in a comment that says "ok" is only a
workaround for some broken systems, too.


Segher
