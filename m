Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 38EB56860C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Nov 2005 00:08:47 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id BF24229EBB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Oct 2005 14:07:09 +0100 (CET)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 27483-06 for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Oct 2005 14:07:09 +0100 (CET)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id A227128067
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Oct 2005 14:07:08 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 31 Oct 2005 15:08:41 +0200
References: <200510280857.44625.david.jander@protonic.nl>
	<200510310921.34696.david.jander@protonic.nl>
	<003501c5de1a$be79b390$0301a8c0@chuck2>
In-Reply-To: <003501c5de1a$be79b390$0301a8c0@chuck2>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510311408.41691.david.jander@protonic.nl>
Subject: Re: Kernel 2.6 on MPC8xx performance trouble...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 31 October 2005 13:58, Mark Chambers wrote:
>[...]
> > No, sir, no cache detected !
> >
> > Where do I have to look now?
>
> Could the cache be in writethrough mode? (Instead of writeback)

Good point. I just checked the same test, but reading instead of writing. Same 
result, no cache detected.

I know how to change cache policy in u-boot, but does the kernel change that? 
If so, where?

Greetings,

-- 
David Jander
