Return-Path: <annamaya@yahoo.com>
Received: from web53805.mail.yahoo.com (web53805.mail.yahoo.com
	[206.190.36.200]) by ozlabs.org (Postfix) with SMTP id C39382BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 01:44:21 +1000 (EST)
Message-ID: <20041013154419.23738.qmail@web53805.mail.yahoo.com>
Date: Wed, 13 Oct 2004 08:44:19 -0700 (PDT)
From: annamaya <annamaya@yahoo.com>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB34811175C16@mail.esn.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: newbie ti Embedded Linux
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

VanBaren has already answered your question in detail.
Use the Linux Kernel from www.denx.de and you should
be fine. Once you have the kernel, start looking into
the arch/ppc/ sub-directory and you will be able to
find all the stuff that you will need to port your new
board. 

And which boot monitor are you planning to use. Just
like VanBaren suggested, I'd go with U-Boot.

--- "Mukund JB." <mukundjb@esntechnologies.co.in>
wrote:

> 
> 
> Hai anamayya,
> 
> I need to port linux to PowerPC based Board?
> 
> 
> Could you give me some specific information about
> this?
> For example, which embedded linux kernel (not
> commercial) is good for
> this job? 
> 
> Regards,
> Mukund jampala
> 
> 



		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
