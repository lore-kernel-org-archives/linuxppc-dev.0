Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 949BDDDE34
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 02:55:38 +1000 (EST)
Message-ID: <46B8A3C9.7060806@ovro.caltech.edu>
Date: Tue, 07 Aug 2007 09:54:33 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Mirek23 <miroslaw.dach@psi.ch>
Subject: Re: signals handling in the kernel
References: <12032525.post@talk.nabble.com>
In-Reply-To: <12032525.post@talk.nabble.com>
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

>     I would like to send signals from the interrupt handler
> routine (in the kernel) to the user application (in user space).
> I have googled on that net and I have found that it could be done with the
> function: kill_proc_info.

Look in Rubini for the section regarding asynchronous
notification, Ch 6.

The callback to generate SIGIO is fasync.

Cheers
Dave
