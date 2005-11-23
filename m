Return-Path: <dwilson@dslextreme.com>
Received: from mail5.dslextreme.com (mail5.dslextreme.com [66.51.199.81])
	by ozlabs.org (Postfix) with SMTP id 8F765687FB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 03:15:35 +1100 (EST)
Message-ID: <200511230816400937.2B36A589@smtp.dslextreme.com>
In-Reply-To: <A49A0ECA-B0EB-4673-928D-0C41D0856635@kernel.crashing.org>
References: <200511230732120750.2B0DEEED@smtp.dslextreme.com>
	<A49A0ECA-B0EB-4673-928D-0C41D0856635@kernel.crashing.org>
Date: Wed, 23 Nov 2005 08:16:40 -0800
From: "Dan Wilson" <dwilson@dslextreme.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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

On 11/23/2005 at 9:51 AM Kumar Gala wrote:

> If I'm not mistaken the Denx kernel is based on 2.6.14. This should  
> have support for the MPC8541.  Realize that the differences between  
> MPC8540 and MPC8541/55 are minor.  Is there something specific on  
> MPC8541 your looking for.
> 
> - kumar

Thanks for the reply!  Unfortunately, I am constrained to use the 2.4=
 kernel by another software package that I have to use, which doesn't yet=
 support 2.6.  It appears to me that the 8541/8555 support was put into 2.6=
 and never back-ported to 2.4.  I'll take a look at the manuals today and=
 compare the 8540 to the 8541: perhaps I can live with the 8540 support=
 that does appear to be in the 2.4 kernel.  If not, hopefully the porting=
 job won't be very difficult.

Thanks for your help!

Dan.
