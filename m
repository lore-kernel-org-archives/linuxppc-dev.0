Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 396A6DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Jun 2008 04:04:32 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4VI4SU5011297
	for <linuxppc-embedded@ozlabs.org>; Sat, 31 May 2008 14:04:28 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4VI4SwY106962
	for <linuxppc-embedded@ozlabs.org>; Sat, 31 May 2008 12:04:28 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4VI4Rxt011390
	for <linuxppc-embedded@ozlabs.org>; Sat, 31 May 2008 12:04:28 -0600
Date: Sat, 31 May 2008 12:57:53 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: dhlii@dlasys.net
Subject: Re: Error occured when appended FPGA image in the section of
	.init.text then bootup
Message-ID: <20080531125753.779c56e6@zod.rchland.ibm.com>
In-Reply-To: <484185E9.6040207@dlasys.net>
References: <BAY124-W49CC670970046CAE18FB33A8B90@phx.gbl>
	<4841270B.9080805@nishioka.com> <484185E9.6040207@dlasys.net>
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

On Sat, 31 May 2008 13:07:53 -0400
"David H. Lynch Jr." <dhlii@dlasys.net> wrote:

> Is there some reason this patch is not getting pushed into mainline ?

Lacks Signed-off-by, support for the board in question doesn't even
exist in arch/ppc anymore, and arch/ppc is going away in June.

josh
