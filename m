Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0644CDDED6
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Jun 2008 05:51:30 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4VJpRf4026326
	for <linuxppc-embedded@ozlabs.org>; Sat, 31 May 2008 15:51:27 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4VJpRXk052414
	for <linuxppc-embedded@ozlabs.org>; Sat, 31 May 2008 13:51:27 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4VJpRXK020792
	for <linuxppc-embedded@ozlabs.org>; Sat, 31 May 2008 13:51:27 -0600
Date: Sat, 31 May 2008 14:44:52 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: dhlii@dlasys.net
Subject: Re: Error occured when appended FPGA image in the section of
	.init.text then bootup
Message-ID: <20080531144452.148db47f@zod.rchland.ibm.com>
In-Reply-To: <48419A3A.3070301@dlasys.net>
References: <BAY124-W49CC670970046CAE18FB33A8B90@phx.gbl>
	<4841270B.9080805@nishioka.com> <484185E9.6040207@dlasys.net>
	<20080531125753.779c56e6@zod.rchland.ibm.com>
	<48419A3A.3070301@dlasys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 31 May 2008 14:34:34 -0400
"David H. Lynch Jr." <dhlii@dlasys.net> wrote:

>  I do not think the patch in question is board specific.
> It has been arround for a long time. And I think alot of people have
> been bitten by the problem.
> It is required for my board.
> I think it is required for any board that generates a large enough image.
> I would be happy to signoff on it - it works/is necescary on my board.

You can't sign off on it.  It's not your patch.  The original author
needs to do so.  See the text of the Developer's Certificate of Origin
1.1, in Documentation/SubmittingPatches.

I really don't think adding this patch is going to do anyone any good
when the entire arch/ppc subdirectory is going to be deleted in a week
or two.

> I can not seem to find the same code in arch/powerpc so I have no clue
> whether something similar might be needed there.

That specific code doesn't exist.

josh
