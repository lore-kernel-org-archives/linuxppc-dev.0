Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1BBD3DDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Aug 2007 01:57:45 +1000 (EST)
Message-ID: <46D6E8DA.9090308@ovro.caltech.edu>
Date: Thu, 30 Aug 2007 08:57:14 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Mirek23 <miroslaw.dach@psi.ch>
Subject: Re: signals handling in the kernel
References: <12032525.post@talk.nabble.com>
	<46B8A3C9.7060806@ovro.caltech.edu>	<46B8BA93.8020909@ovro.caltech.edu>
	<12048448.post@talk.nabble.com>	<46B9FB23.8040903@ovro.caltech.edu>
	<12409543.post@talk.nabble.com>
In-Reply-To: <12409543.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi Mirek,

> I went throught the Rubini book about device drivers
> and I see that you are absolutly right about
> the way how to handle interrupts in the user space. 

Great, glad to hear you are convinced :)

> When I find a bit of time I will try your first
> suggestion with read() which blocks in the user space
> and waits for ISR to write data to the buffer.

Look at the example drivers I wrote. Its all in
there, just copy whatever you want.

> Many thanks for all your suggestions

No problem! Its the open-source way ;)

Cheers,
Dave
