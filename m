Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 6DE5667A7F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Feb 2005 19:23:25 +1100 (EST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 96A7E52DD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Feb 2005 09:23:27 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 18 Feb 2005 09:23:20 +0100
References: <EF9B29C78F41FA488927FCBC7750AF0E08DA18@hyd-mdp-msg.wipro.com>
In-Reply-To: <EF9B29C78F41FA488927FCBC7750AF0E08DA18@hyd-mdp-msg.wipro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502180923.20638.david.jander@protonic.nl>
Subject: Re: Freeing unused kernel memory: 56k init - hang problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 18 February 2005 05:16, srinivas.surabhi@wipro.com wrote:
> Is there any patch for ppc-8260 for the hang problem after the following
> output on the serial console.
>
> "Freeing unused kernel memory: 56k init"

I don't know about any known "hang problem" or such, but at that point, 
normally your root filesystem is mounted and /sbin/init is executed. So if it 
hangs there, probably something is wrong with your root filesystem.
Could you tell more about what board/kernel/sdk/etc... you are using? Where is 
"/" supposed to be mounted from? NFS? flash? initrd?

Greetings,

-- 
David Jander
Protonic Holland.
