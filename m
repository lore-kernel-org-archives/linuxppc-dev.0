Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE94A687EA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 03:18:54 +1100 (EST)
In-Reply-To: <200511230816400937.2B36A589@smtp.dslextreme.com>
References: <200511230732120750.2B0DEEED@smtp.dslextreme.com>
	<A49A0ECA-B0EB-4673-928D-0C41D0856635@kernel.crashing.org>
	<200511230816400937.2B36A589@smtp.dslextreme.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <876043CF-5CC2-409D-A543-8C90C5E92097@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 23 Nov 2005 10:19:38 -0600
To: "Dan Wilson" <dwilson@dslextreme.com>
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


On Nov 23, 2005, at 10:16 AM, Dan Wilson wrote:

> On 11/23/2005 at 9:51 AM Kumar Gala wrote:
>
>> If I'm not mistaken the Denx kernel is based on 2.6.14. This should
>> have support for the MPC8541.  Realize that the differences between
>> MPC8540 and MPC8541/55 are minor.  Is there something specific on
>> MPC8541 your looking for.
>>
>> - kumar
>
> Thanks for the reply!  Unfortunately, I am constrained to use the  
> 2.4 kernel by another software package that I have to use, which  
> doesn't yet support 2.6.  It appears to me that the 8541/8555  
> support was put into 2.6 and never back-ported to 2.4.  I'll take a  
> look at the manuals today and compare the 8540 to the 8541: perhaps  
> I can live with the 8540 support that does appear to be in the 2.4  
> kernel.  If not, hopefully the porting job won't be very difficult.

I believe the linuxppc-dev 2.4 tree had support for the MPC8541/55.

- kumar
