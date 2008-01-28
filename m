Return-Path: <sheflin@newagemicro.com>
Received: from server196.onecontrol.com (ip-66-129-110-196.name-host.com
	[66.129.110.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9C1C4DDEE1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jan 2008 09:47:09 +1100 (EST)
Date: Mon, 28 Jan 2008 17:46:47 -0500
To: linuxppc-embedded@ozlabs.org
From: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: Preferred GIT URL for arch/powerpc, and BINUTILS
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-Id: <20080128224710.9C1C4DDEE1@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

At 02:30 PM 1/28/2008, Steve Heflin wrote:
>Josh, you're a life saver!!  Your GIT tree is exactly what I've been
>looking for. I have an AMCC440EPx based product that makes heavy use
>of all the devices embedded in the microcontroller. I'll be able to
>give that platform a very good testing.
>
>Now can you help me with BINUTILS?  What version do you use and can
>you point me to a decent GIT tree for it?  I tried to use version
>2.18 and the build blows up because it tries to "strip" a script file
>"embedspu".

Whoa! I spoke too soon.  Upon attempting a "make menuconfig" on the 
2.6.24-rc8 which I cloned from your git tree, I don't even SEE the 
powerpc architecture appearing!  What's up?
