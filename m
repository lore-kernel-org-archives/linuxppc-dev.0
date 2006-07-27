Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9114B679E7
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2006 10:04:51 +1000 (EST)
In-Reply-To: <A958F7B12F59EC408E904A912CDE3DAE3D6A07@cvn68.fairmountautomation.com>
References: <A958F7B12F59EC408E904A912CDE3DAE3D6A07@cvn68.fairmountautomation.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E7ECF775-1E54-4EE8-98DA-89FAD5C7C03A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Can 750 user-mode binaries run on a 603e core?
Date: Wed, 26 Jul 2006 19:04:59 -0500
To: Patrick J. Kelsey <KelseyPJ@fairmountautomation.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 26, 2006, at 5:27 PM, Patrick J. Kelsey wrote:

> Hi,
>
> If have user-mode binaries built for a 750 core, say with gcc - 
> mcpu=750, should I expect them to run on a 603e core?  Would I have  
> to worry about unsupported instructions or instruction scheduling  
> issues?
>
> If there's a better list for this question, please advise.

Sure, there isn't different in the user space instruction sets  
between the 750 and 603e core.  The -mcpu is only tweaking  
instruction scheduling and making it specific for the 750.  The  
instruction scheduling differences aren't that huge if memory serves  
me correctly.  The 750 probably takes fewer cycles on multiple and  
divides.  I forget if the 750 has any additional execution units that  
the 603e didn't have (additional integer units, etc.).

- kumar
