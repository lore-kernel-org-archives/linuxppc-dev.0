Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 34CBCDDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Jan 2008 13:01:36 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0S21XJ9026390
	for <linuxppc-embedded@ozlabs.org>; Sun, 27 Jan 2008 21:01:33 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0S21Xhw113676
	for <linuxppc-embedded@ozlabs.org>; Sun, 27 Jan 2008 19:01:33 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0S21XxU022305
	for <linuxppc-embedded@ozlabs.org>; Sun, 27 Jan 2008 19:01:33 -0700
Date: Sun, 27 Jan 2008 20:00:44 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: Reminder: removal of arch/ppc - (Sequoia)
Message-ID: <20080127200044.148982a6@zod.rchland.ibm.com>
In-Reply-To: <20080127233751.A6F9EDDDF0@ozlabs.org>
References: <20080127231214.1F50ADDDE9@ozlabs.org>
	<20080127233923.GA5550@lixom.net>
	<20080127233751.A6F9EDDDF0@ozlabs.org>
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

On Sun, 27 Jan 2008 18:37:22 -0500
Steve Heflin <sheflin@newagemicro.com> wrote:

> Hello!
> 
> Yes! I'm looking at 2.6.23.14 as I thought that was the newest 
> version. I completely missed seeing the 2.6.24 kit, thank you so much!!

FYI, 2.6.24 is considered fairly old relatively speaking.  With so much
activity going on for the embedded boards for arch/powerpc, you're sort
of missing out if you aren't running from the latest git trees.

Yes, I realize how ridiculous it sounds to say a kernel that was just
released 3 days ago is old, but that's reality.

josh
