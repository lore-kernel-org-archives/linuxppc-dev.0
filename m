Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0B07F679FB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Feb 2006 11:01:54 +1100 (EST)
Message-ID: <43F3C0D2.3000207@ovro.caltech.edu>
Date: Wed, 15 Feb 2006 16:01:22 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PowerQUICC II Pro MPC8349E-MDS Linux 2.6 support
References: <Pine.LNX.4.44.0602151743030.450-100000@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0602151743030.450-100000@gate.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

>> ... for the MPC8349E-MDS board?
> 
> Yes, Freescale names the board four different things durings its 
> development (ADS, SYS, MDS, ok maybe only three :)

Ok, great.

>>In the Denx source, there is modified versions for the
>>TQM board, but I wasn't sure what platform the original
>>files were targeted for. 
> 
> Not sure, I follow.  The MPC834x MDS was the first 834x system supported.

Sorry, my fault, I wasn't clear.

I was just referring to the fact that in addition to your
source, the Denx tree also has the work they are doing on
the TQM board that contains an 8349E.

> However, if you are looking at 834x, I recommend you grab my u-boot tree 
> from kernel.org since it has support for booting the kernel with a flat 
> device tree.  From 2.6.16, all future 83xx work will be done in 
> arch/powerpc which requires a flat dev tree to boot.

Ok.

The reason I was asking, was that I want to benchmark an 8349E
based system. Wolfgang Denx mentioned the TQM system, so I took
a look in the Denx tree, and saw that their work was based
on yours. I assumed your work was for a Freescale reference board,
but didn't know which.

Thanks for the clarification.

Dave
