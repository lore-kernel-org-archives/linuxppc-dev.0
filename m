Return-Path: <nm127@freemail.hu>
Received: from relay02.digicable.hu (relay02.digicable.hu [92.249.128.188])
	by ozlabs.org (Postfix) with ESMTP id C1261B7CB8
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 05:44:31 +1100 (EST)
Message-ID: <4B95458A.4000304@freemail.hu>
Date: Mon, 08 Mar 2010 19:44:26 +0100
From: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: cross-compiling Linux for PowerPC e200 core?
References: <4B934CCA.8030608@freemail.hu>
	<fa686aa41003080934q5d5bebabl7d582d1264da4dcd@mail.gmail.com>
In-Reply-To: <fa686aa41003080934q5d5bebabl7d582d1264da4dcd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> 2010/3/6 Németh Márton <nm127@freemail.hu>:
>> Hi,
>>
>> I'm trying to cross-compile Linux 2.6.33 for Freescale MPC5554 [1][2]. This
>> microcontroller is based on the e200z6 core. I could build the cross-development
>> tools, but I could miss something because I get an error message when building
>> Linux for PowerPC e200 core. Here are the steps I used:
> 
> I doubt you'll have much luck with the mpc5554.  Linux doesn't include
> any support for the MPC5554, and I don't think anybody is working on
> it.  Any of the mpc5554 systems I've see don't have enough ram to run
> Linux well.

I'm ready to work a bit more than just compiling the kernel and run it on MPC5554.
On my target system there is a possibility to use external RAM connected to the
External Bus Interface, so I don't see this would be a problem in my case.

However, I have not much experience running Linux on PowerPC environment. Could
you suggest a PowerPC port which would be a good starting point to make support
for MPC5554?

As far as I could find out I'll need to create a device tree as documented in
the linux/Documentation/powerpc/booting-without-of.txt file.

Regards,

	Márton Németh
