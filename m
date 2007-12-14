Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 9F36ADE01A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Dec 2007 13:48:09 +1100 (EST)
In-Reply-To: <9e4733910712131828v532e6aaep316c72e14d92c921@mail.gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: How is a device tree used to specifiy flash?
MIME-Version: 1.0
Message-ID: <OF24048468.087C44B1-ON882573B1.000F3814-882573B1.000F6220@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 13 Dec 2007 18:48:01 -0800
Content-Type: text/plain; charset="US-ASCII"
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

"Jon Smirl" <jonsmirl@gmail.com> wrote on 12/13/2007 06:28:28 PM:

> To get this working on the mpc5200 I had to add the localbus node
> above the flash.
> 
>    lpb@ff000000 {
>       compatible = "fsl,lpb";
>       ranges = <0 ff000000 01000000>;
> 

Thanks.  I'll give it a try.  Do you know if the "fsl,lpb" compaibility 
extends to the 83xx code?

Bruce
