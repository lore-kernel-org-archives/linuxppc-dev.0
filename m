Return-Path: <sheflin@newagemicro.com>
Received: from server196.onecontrol.com (ip-66-129-110-196.name-host.com
	[66.129.110.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7583BDDF14
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jan 2008 06:30:27 +1100 (EST)
Date: Mon, 28 Jan 2008 14:30:03 -0500
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>,linuxppc-embedded@ozlabs.org
From: Steve Heflin <sheflin@newagemicro.com>
Subject: Preferred GIT URL for arch/powerpc, and BINUTILS
In-Reply-To: <20080128114559.5502b42f@zod.rchland.ibm.com>
References: <20080127200044.148982a6@zod.rchland.ibm.com>
	<C3C34A58.D10E%gerickson@nuovations.com>
	<20080128114559.5502b42f@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-Id: <20080128193029.7583BDDF14@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Josh, you're a life saver!!  Your GIT tree is exactly what I've been 
looking for. I have an AMCC440EPx based product that makes heavy use 
of all the devices embedded in the microcontroller. I'll be able to 
give that platform a very good testing.

Now can you help me with BINUTILS?  What version do you use and can 
you point me to a decent GIT tree for it?  I tried to use version 
2.18 and the build blows up because it tries to "strip" a script file 
"embedspu".

thanks so much,
Steve
