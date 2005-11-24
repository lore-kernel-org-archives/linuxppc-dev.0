Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 059EA68809
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 19:25:30 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id C337F29EBC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 09:23:48 +0100 (CET)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 11340-09 for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 09:23:48 +0100 (CET)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id E87EF29EBB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 09:23:47 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 24 Nov 2005 10:25:21 +0200
References: <000901c5f03c$5d4e8c60$6405a8c0@absolut>
	<4384921A.8010901@fagorautomation.es>
In-Reply-To: <4384921A.8010901@fagorautomation.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200511240925.21942.david.jander@protonic.nl>
Subject: Re: USB Keyboard Support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> root=/dev/nfs rw ip=on console=tty console=ttyS0 init=/sbin/init

I suppose putting two "console=" statements on the commandline doesn't do much 
more than just removing the first one.

Greetings,

-- 
David Jander
