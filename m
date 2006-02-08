Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 7200268A1F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Feb 2006 01:02:13 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 6D1AA29ECA
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 15:00:31 +0100 (CET)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 30554-02 for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 15:00:29 +0100 (CET)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 36BEF29EC9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Feb 2006 15:00:29 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: Re: How to check which CPU we are using? PPC?
Date: Wed, 8 Feb 2006 15:02:02 +0100
References: <20060115171949.2EB36353AB0@atlas.denx.de>
	<200602081225331876279@126.com>
In-Reply-To: <200602081225331876279@126.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Message-Id: <200602081502.02174.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 08 February 2006 14:04, jeanwelly wrote:
> Hi,
> Acutally I am asking "Are there any command that os or BSP provided in
> shell to print the CPU information?". Thanks a lot!

One guess: cat /proc/cpuinfo

Will that be it?

Geetings,

-- 
David Jander
