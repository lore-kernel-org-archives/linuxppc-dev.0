Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id 79BBC2BF12
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jan 2005 23:13:13 +1100 (EST)
To: Robin <robin@india.tejasnetworks.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 05 Mar 2005 23:05:55 +0530."
	<4229EDFB.2040402@india.tejasnetworks.com>
Date: Thu, 06 Jan 2005 13:12:33 +0100
Sender: wd@denx.de
Message-Id: <20050106121238.BB99AC108D@atlas.denx.de>
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

In message <4229EDFB.2040402@india.tejasnetworks.com> you wrote:
>
> I am trying to find a way of setting TZ environment variable with DST

Your subject is misleading. Timezone handling is a user space  issue.
It has nothing to do with the kernel verison.

> I am using 2.4.20 linux kernel from denx.I am running date command from

This has nothing to do with your problems.

> busybox version 0.6 which in is using strftime. The processor is ppc860T.

BB 0.6 ? AFAICT there is no such version. Do you mean  busybox-0.60.5 ?

This is awfully old. Maybe  you  should  try  running  an  up-to-date
version  of  busybox  first?  If  this doesn;'t work, please consider
using the real GNU date  command.  You  should  understand  that  the
busybox  tools  only provide limited functionality, so fancy features
like complex timezone support may not be available.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Status quo. Latin for "the mess we're in."
