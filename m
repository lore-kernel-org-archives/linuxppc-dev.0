Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-33.bluehost.com (outbound-mail-33.bluehost.com
	[70.96.188.153]) by ozlabs.org (Postfix) with SMTP id EAE4268967
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 07:01:22 +1100 (EST)
Message-ID: <43B43EE4.6010900@secretlab.ca>
Date: Thu, 29 Dec 2005 12:54:12 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <43B2EFD0.4010709@ru.mvista.com> <20051229194014.GC8842@dmt.cnet>
In-Reply-To: <20051229194014.GC8842@dmt.cnet>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/2] ppc32: Make platform devices being able to assign
 functions (resend)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti wrote:
> Hi Vitaly,
> 
> On Wed, Dec 28, 2005 at 11:04:32PM +0300, Vitaly Bordug wrote:
> 
>>Implemented by  modification of the .name field of the platform device,
>>when PDs with the
>>same names are to be used within different drivers, as
>><device_name> -> <device_name>:<function>
>>Corresponding drivers should change the .name in struct device_driver to
>>reflect upper of course.
> 
> 
> I'm not certain that the <device_name>:<function> structure for sysfs   
> representation is "allowed" - have you asked GregKH about it?
> 
>
He didn't seem to have any problem with it when we talked about it at
OLS.  Also, ':' is already used by the PCI bus driver.  Look in
/sys/class/pci_bus.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
