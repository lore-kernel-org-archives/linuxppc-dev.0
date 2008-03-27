Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6D63EDE001
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Mar 2008 12:06:09 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2R162Ca031111
	for <linuxppc-embedded@ozlabs.org>; Wed, 26 Mar 2008 21:06:02 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2R161eg220526
	for <linuxppc-embedded@ozlabs.org>; Wed, 26 Mar 2008 19:06:01 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2R1616T028691
	for <linuxppc-embedded@ozlabs.org>; Wed, 26 Mar 2008 19:06:01 -0600
Date: Wed, 26 Mar 2008 20:03:23 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Dave Cogley" <dcogley@uslinc.com>
Subject: Re: ppc platform for AMCC-440EPx - ELDK to the rescue
Message-ID: <20080326200323.69eac31f@zod.rchland.ibm.com>
In-Reply-To: <006e01c88f94$9dafe020$2001a8c0@DCOGLEYNEW>
References: <20080326130837.762DBDE2FB@ozlabs.org>
	<20080326222247.337AB242FC@gemini.denx.de>
	<006e01c88f94$9dafe020$2001a8c0@DCOGLEYNEW>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 26 Mar 2008 15:56:23 -0700
"Dave Cogley" <dcogley@uslinc.com> wrote:

> Wolfgang,
> 
> Could you provide an explanation between the two architectures in the ELDK?
> 
> 
> I am also using a Sequoia "spin off" and am trying to determine why I would
> want to use the "powerpc" architecture vs. the "ppc" architecture.  

arch/ppc is being removed entirely from the kernel.org kernels in June.

josh
