Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C516687D0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 02:51:11 +1100 (EST)
In-Reply-To: <200511230732120750.2B0DEEED@smtp.dslextreme.com>
References: <200511230732120750.2B0DEEED@smtp.dslextreme.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A49A0ECA-B0EB-4673-928D-0C41D0856635@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 23 Nov 2005 09:51:53 -0600
To: Dan Wilson <dwilson@dslextreme.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Freescale 8541 support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 23, 2005, at 9:32 AM, Dan Wilson wrote:

> Hello,
>
> I am trying to find embedded linux support for the Freescale  
> 8541/8555 processor.  I downloaded the latest ELDK sources from the  
> Denx CVS server and found 8540 support in there but nothing (unless  
> I missed it) for the 8541.
>
> Does anyone know of any support for that processor?

If I'm not mistaken the Denx kernel is based on 2.6.14. This should  
have support for the MPC8541.  Realize that the differences between  
MPC8540 and MPC8541/55 are minor.  Is there something specific on  
MPC8541 your looking for.

- kumar
