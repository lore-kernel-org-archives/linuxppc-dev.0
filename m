Message-ID: <4125AA2C.6070306@vmetro.no>
Date: Fri, 20 Aug 2004 09:37:16 +0200
From: Carl Aage Amundsen <carl@vmetro.no>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>,
	Eugene Surovegin <ebs@ebshome.net>
Cc: Steven Blakeslee <BlakesleeS@embeddedplanet.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 405GPr PCI target/host
References: <D73A25AA6E54D511AD74009027B1110F5BB389@ORION> <1092947874.10314.146.camel@localhost>
In-Reply-To: <1092947874.10314.146.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Adrian, Eugene

You both mentioned using a custom point-to-point driver that enables
CPUs on the same PCI bus system to communicate together using TCP/IP. Is
such a driver publicly available ?

I have worked with similar drivers in VxWorks (SMnet and Busnet) where
they are a _must_, but now we are in the process of bringing up Linux on
our embedded products. I think such a driver should be part of the
standard Linux kernel in order to support a definite need in the
embedded community.

Thanks and regards,
Carl Aage Amundsen



Adrian Cox wrote:

>On Thu, 2004-08-19 at 19:28, Steven Blakeslee wrote:
>
>
>>I am trying to get an IBM 405GPr processor to work as a target/host on a PCI
>>bus.  A PCI target can temporarily become a host on the PCI bus. Basically
>>this means it needs to do everything the host currently does except
>>assigning PCI memory space, the dedicated host is responsible for this.
>>
>>
>
>
>
>>[snip]
>>
>>
>
>
>
>>I was wondering if anyone has done something like this, not necessarily with
>>a 405, any processor experience will do.  I appreciate any help or advice.
>>
>>
>
>I've written drivers for several systems of this form. Generally people
>are trying to do one of the following:
>1) Communicate between the PCI root (running Linux, Windows, or anything
>else) and embedded Linux on a non-root processor. This requires a custom
>driver, but is essentially straightforward. Eugene Surovegin has
>described this elsewhere in the thread.
>2) Communicate between embedded Linux on a non-root processor and custom
>electronics on another non-root device. This also requires a
>straightforward custom driver.
>3) Use a standard Linux device driver running on a non-root processor to
>control a standard PCI device elsewhere on the bus. This is usually
>unsolvable without a custom motherboard to provide the required
>interrupt routing. Most people give up and use a non-transparent PCI
>bridge instead.
>
>Does your requirement fit one of those?
>
>- Adrian Cox
>http://www.humboldt.co.uk/
>
>
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
