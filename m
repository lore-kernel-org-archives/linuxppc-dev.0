Return-Path: <ejohnson@acdstar.com>
Received: from mail.acdstar.com (mail.acdstar.com [209.98.244.9])
	by ozlabs.org (Postfix) with ESMTP id 4EFD1686C2
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 08:12:17 +1100 (EST)
Message-Id: <6.2.5.6.1.20051107145546.01d91498@acdstar.com>
Date: Mon, 07 Nov 2005 15:04:32 -0600
To: bennett78@digis.net, linuxppc-embedded@ozlabs.org
From: "Eric N. Johnson (ACD)" <ejohnson@acdstar.com>
In-Reply-To: <436D068A.7030905@digis.net>
References: <436D068A.7030905@digis.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: Re: MPC5200 I2S driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>I would be interested in getting any driver code
>examples for Bestcomm/PSC6/CODEC for the mpc5200
>as well.

There was an earlier discussion on this list.  Have a look at:
http://ozlabs.org/pipermail/linuxppc-embedded/2005-September/020210.html

That message has the code we've used to run an I2S DAC on the 
MPC5200.  It's been stable, although we've not done extensive 
testing.  You'll also have to prune out the code that's specific to 
our hardware, and it supports output only.  We have not tried using I2S inputs.

Eric

------------------------------------
Eric Johnson, Electrical Engineer
Advanced Communication Design
   7901 12th Avenue South
   Bloomington, MN 55425
Ph: 952-854-4000  Fax: 952-854-5774
