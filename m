Return-Path: <msm@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 5AE16679E2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Aug 2006 00:30:41 +1000 (EST)
Subject: Re: Gianfar eth driver on 8540 ppc - for 2.4 and 2.6 :
	different	outputs
From: Matthew McClintock <msm@freescale.com>
To: Prashant Yendigeri <Prashant.Yendigeri@lntinfotech.com>
In-Reply-To: <OF1D72900B.401371DD-ON652571C7.0045AB5D-652571C7.0045E5FC@lntinfotech.com>
References: <OF1D72900B.401371DD-ON652571C7.0045AB5D-652571C7.0045E5FC@lntinfotech.com>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 09:30:32 -0500
Message-Id: <1155306633.5252.1.camel@localhost>
Mime-Version: 1.0
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

On Fri, 2006-08-11 at 18:13 +0530, Prashant Yendigeri wrote:
> Hi, 
> 
> This is a standard board designed by GDA technologies Inc.
> (www.gdatech.com) and eth on 2.4.20 works very much. 

I used a 8540 GDA board once upon a time and all I needed to do was to
change the PHY address. Lookat your 2.4 source and determine what the
correct value is and double check.

-Matthew
