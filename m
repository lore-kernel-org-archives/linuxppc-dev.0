Return-Path: <wd@denx.de>
Received: from mailout04.sul.t-online.com (mailout04.sul.t-online.com
	[194.25.134.18]) by ozlabs.org (Postfix) with ESMTP id 470E168342
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 15:46:27 +1000 (EST)
To: =?UTF-8?Q?=E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84EMAIL?= <rober@opnet.com.tw>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 21 Sep 2005 10:07:25 +0800."
	<1127268445.7865.4.camel@banana>
Date: Wed, 21 Sep 2005 07:45:59 +0200
Sender: wd@denx.de
Message-Id: <20050921054559.BB1E635265F@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: How to add user at linux 2.4.25 with eldk 3.1.1 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <1127268445.7865.4.camel@banana> you wrote:
> 
>      How to add a new user at 2.4.25 linux. I used nfs as filesystem
> (/opt/eldk/ppc_8xx).

Edit /etc/passwd and add a new entry.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A person who is more than casually interested in computers should  be
well  schooled in machine language, since it is a fundamental part of
a computer.                                           -- Donald Knuth
