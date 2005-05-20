Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A646679FE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 May 2005 18:54:52 +1000 (EST)
Date: Fri, 20 May 2005 09:54:43 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "Gopala Krishnam Raju" <graju@facetime.com>
Message-Id: <20050520095443.16a4ad4d.ajz@cambridgebroadband.com>
In-Reply-To: <83986B58C72FC447AAC98F916BAB6A5735D90A@postman.facetime.com>
References: <83986B58C72FC447AAC98F916BAB6A5735D90A@postman.facetime.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: regarding kernel for montavista
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

You haven't said a lot of things.

1.	What board are you using (and how did you create .config)
2.	What was the last thing the kernel said (i.e. where did it crash)
3.	Did it oops?  If so where did the oops say it crashed
	(read man ksymoops; generate output; post it to the list)

Alex


On Fri, 20 May 2005 09:55:57 +0530
"Gopala Krishnam Raju" <graju@facetime.com> wrote:

> hello
> 
> 1. I have compiled the montavista kernel
> 
> 2. I have done made the make dep
> 
> 3. I have done make install
> 
> 4. I have done makeinitrd-pxe also 
> 
> Every thing went well but when i boot this on the target it is giving
> the kernel panic error.  I tried with enforcing=0 also then also the
> problem is not solved.
> 
> please help me out 
> 
> Thanks in advance
> 
> Regards
> 
> GGKRAJU
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
