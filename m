Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 07838DDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jun 2007 17:22:28 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id C012729EC5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jun 2007 09:19:54 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 15156-03 for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jun 2007 09:19:53 +0200 (CEST)
Received: from archvile.prtnl (archvile.prtnl [192.168.1.153])
	by protonic.prtnl (Postfix) with ESMTP id E797029EBC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jun 2007 09:19:52 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: Re: CAN YOU HELLP ME
Date: Wed, 20 Jun 2007 09:23:44 +0200
References: <loom.20070620T040706-80@post.gmane.org>
In-Reply-To: <loom.20070620T040706-80@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706200923.44248.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 20 June 2007 04:20:09 volcano wrote:
> hello my dear friend:
>    I have read the u-boot last week ,and thank you for all your kind
> help.My linux code is based on MPC8260,so I want to continue the read of
> the linux2.6.18 based on mpc8260.can you give me some kind suggestions
> about how to read all these codes clearly.,and if some reference is given
> would be welcome.

I suppose you want to have something as a guide to the linux-kernel 
source-code, right?
Well, I haven't found anything like that exactly, but luckily the source-code 
is mostly quite easy to understand, and after fiddling for a while you'll get 
the hang of it.

Here you might find some useful information on books and on-line material over 
the linux kernel:

http://www.linux.org/dist/kernel.html

It is also helful to check the lkml (linux-kernel-mailing list) every now and 
then, to see what's "hot".

The kernel itself is in constant changes that happen so quickly, that after 
finishing a guide like this, you would probably already need to change it. 
Therefore it is the intention to make the linux-kernel sources as readable as 
possible, so that the code is self-explanatory. The code itself is the 
manual.

Greetings,

-- 
David Jander
