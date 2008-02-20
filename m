Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0AD52DDE28
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 23:08:03 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1KC7xbo026855
	for <linuxppc-embedded@ozlabs.org>; Wed, 20 Feb 2008 07:07:59 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1KC7x0J228728
	for <linuxppc-embedded@ozlabs.org>; Wed, 20 Feb 2008 07:07:59 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1KC7xGa002483
	for <linuxppc-embedded@ozlabs.org>; Wed, 20 Feb 2008 07:07:59 -0500
Date: Wed, 20 Feb 2008 06:06:53 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Silwer star <fariyaf@gmail.com>
Subject: Re: Sample driver
Message-ID: <20080220060653.7593ffa9@zod.rchland.ibm.com>
In-Reply-To: <15582059.post@talk.nabble.com>
References: <15582059.post@talk.nabble.com>
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

On Tue, 19 Feb 2008 20:13:24 -0800 (PST)
Silwer star <fariyaf@gmail.com> wrote:

> 
> Does anyone have sample drivers in Linux for the EBC interface for PPC405Ex?
> I would be thankful if someone could put in a sample code here. 

Linux typically doesn't touch the EBC itself.  That is normally set up
by firmware such as U-Boot and Linux uses it as-is.

josh
