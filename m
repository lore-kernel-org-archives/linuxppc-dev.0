Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from agrxsusmail.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 3057A67A3A
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2006 22:36:07 +1000 (EST)
Message-ID: <44C8B330.7030600@smiths-aerospace.com>
Date: Thu, 27 Jul 2006 08:36:00 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: "Patrick J. Kelsey" <KelseyPJ@fairmountautomation.com>
Subject: Re: Can 750 user-mode binaries run on a 603e core?
References: <A958F7B12F59EC408E904A912CDE3DAE3D6A07@cvn68.fairmountautomation.com>	<E7ECF775-1E54-4EE8-98DA-89FAD5C7C03A@kernel.crashing.org>
	<A958F7B12F59EC408E904A912CDE3DAE3D6A0A@cvn68.fairmountautomation.com>
In-Reply-To: <A958F7B12F59EC408E904A912CDE3DAE3D6A0A@cvn68.fairmountautomation.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Patrick J. Kelsey wrote:
> (sorry about that last one. had a bit of trouble with a certain web based mail client...) 
>  
> Thanks for the reply, Kumar.
>  
> That sounds encouraging.  One of the things I was worried about with
> scheduling differences would be a differing number of branch delay
> slots between the two core versions.  I'm still a bit new to the
> details of the PowerPC architecture, and at this point I'm not even
> sure if there are branch delay slots, although it does seem from my
> reading that the 603e and 750 pipelines are the same, in which case
> there would ceratinly be no worries here.

FWIIW, the PowerPC architecture has hardware instruction interlocking 
and scheduling and doesn't require the compiler to implement the branch 
delay slots like, for instance, the MIPS architecture.  This is much 
more compiler and portability friendly, but at the expense of more logic 
in the processor (the PowerPC is not nearly as minimalistic as the MIPS).

> At this point, I'm not concerned so much about an inefficient
> schedule resulting from running -mcpu=750 code on a 603e as long as
> the execution is correct.
>  
> Pat

gvb
