Return-Path: <mgroeger@sysgo.com>
Received: from mailgate.sysgo.de (ns.sysgo.de [213.68.67.98])
	by ozlabs.org (Postfix) with ESMTP id B62032BF12
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Jan 2005 01:26:03 +1100 (EST)
Date: Thu, 6 Jan 2005 14:56:20 +0100 (CET)
From: Marius Groeger <mgroeger@sysgo.com>
Sender: mag@sysgo.com
To: Robin <robin@india.tejasnetworks.com>
In-Reply-To: <41DC9568.6090106@india.tejasnetworks.com>
Message-ID: <Pine.LNX.4.61.0501061450190.4945@mag.sysgo.com>
References: <20050106121238.BB99AC108D@atlas.denx.de>
	<41DC9568.6090106@india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: TZ variable setting for denx 2.4.20
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Robin,

On Thu, 6 Jan 2005, Robin wrote:

> I have tried with the standard linux date too. That too doesnt seem 
> to consider timezone variable that has been set. Can you give me a 
> way for setting timezone for southern hemisphere countries?? The 
> busybox code uses strftime function. But that does not seem to 
> consider TZ variable...

You should read up on how glibc handles all that timezone stuff:

   sh# info libc "TZ Variable"

Most notably, make sure you /etc/localtime is set up correctly. There 
is also a tool (script) called tzselect which may be helpful for you.

Note I'm not exactly an expert on this, I'm just giving pointers...

Regards,
Marius

-- 
Marius Groeger <mgroeger@sysgo.com>
SYSGO AG                      Embedded and Real-Time Software
Voice: +49 6136 9948 0                  FAX: +49 6136 9948 10
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com
