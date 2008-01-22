Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 44964DDE11
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jan 2008 03:45:52 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0MGjm5x001697
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Jan 2008 11:45:48 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0MGjdih086778
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Jan 2008 09:45:41 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0MGjd3v008823
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Jan 2008 09:45:39 -0700
Date: Tue, 22 Jan 2008 10:45:38 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Angelo <s104259@yahoo.it>
Subject: Re: framebuffer swap endianess
Message-ID: <20080122104538.4baadd3e@weaponx>
In-Reply-To: <323144.65236.qm@web23105.mail.ird.yahoo.com>
References: <323144.65236.qm@web23105.mail.ird.yahoo.com>
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

On Tue, 22 Jan 2008 16:46:47 +0100 (CET)
Angelo <s104259@yahoo.it> wrote:

> Hi, i'm angelo.
> 
> I have just create a framebuffer for an embedded system:
> - powerpc (little endian)  with  a GPU (big endian).

I think you have those backwards?  PowerPC is big-endian...

josh
