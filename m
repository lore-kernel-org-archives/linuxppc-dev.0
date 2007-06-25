Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 8EC91DDE33
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 02:07:59 +1000 (EST)
Message-ID: <467FE8BF.6060407@mvista.com>
Date: Mon, 25 Jun 2007 09:09:35 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: setup Marvell mv64x60 platform devices for EDAC
References: <20070522232432.GA26046@blade.az.mvista.com>
	<18047.24840.233508.259767@cargo.ozlabs.ibm.com>
In-Reply-To: <18047.24840.233508.259767@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Doug Thompson <norsk5@yahoo.com>, dfarnsworth@mvista.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Dave Jiang writes:
> 
>> The mv64x60 EDAC driver can be found at:
>> http://bluesmoke.sourceforge.net/
>>
>> It's in development to be pushed into the kernel.
> 
> Am I correct in thinking this patch is useless without that driver?
> 
> Is that driver being submitted for 2.6.23?  If so, who is submitting
> it and to whom?  Does it look like it will be accepted?
> 
> Paul.

Paul,

Yes you are correct. I have not yet submitted the driver to akpm. I'm waiting
for the core EDAC changes to be accepted, which are in the mm tree right now.
The driver relies on some new API changes to EDAC that are in the mm tree.
Without those changes the driver is pretty useless. The driver is publicly
available from the sourceforge EDAC SVN at the moment and patches against the
latest mm tree. If you like I can ask Doug Thompson (the EDAC maintainer) to
put the driver in the mm tree.

This is also the same for the mpc85xx EDAC driver. Of course that needs the
publish of the of_device patch.

-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
