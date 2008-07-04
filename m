Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id 0F7B8DDE98
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jul 2008 20:30:12 +1000 (EST)
Message-ID: <486DF79C.1000202@scram.de>
Date: Fri, 04 Jul 2008 12:12:44 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Thomas Maenner <tmaenner@aehr.com>
Subject: Re: Need stable 2.6 kernel for TQM823L
References: <200807021418.13596.tmaenner@aehr.com>	<200807031159.30434.tmaenner@aehr.com>	<20080703190440.GA3098@secretlab.ca>
	<200807031839.19123.tmaenner@aehr.com>
In-Reply-To: <200807031839.19123.tmaenner@aehr.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Hi Tom,

> Not exactly what I was hoping to hear...
> 
> What are the reasons to not port these TQs to 2.6?
> Lack of resources? Not enough interest?

It's probably not enough interest.

However, the port should be fairly easy. Some time ago, I posted a
port for the Dbox2 hardware, which is also based on the MPC823 CPU.
You can use this as a starting point just by ripping off the DBox2
specific parts (you'd have to convert the device tree to v1 though):

http://patchwork.ozlabs.org/linuxppc/patch?person=1023&id=15875

Thanks,
Jochen
