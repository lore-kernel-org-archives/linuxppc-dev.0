Return-Path: <wd@denx.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id 902FE67E9C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 07:22:00 +1000 (EST)
To: =?UTF-8?Q?=E5=BE=90=E5=8B=9D=E5=A8=81=E7=9A=84EMAIL?= <rober@opnet.com.tw>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 09 Aug 2005 14:25:15 +0800."
	<1123568715.4219.7.camel@banana>
Date: Tue, 09 Aug 2005 23:21:22 +0200
Sender: wd@denx.de
Message-Id: <20050809212122.7E5C3352BD9@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: about building RTAI 24.1.12 at Linux 2.4.25 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <1123568715.4219.7.camel@banana> you wrote:
> 
>     I got some error while make RTAI, anybody know how to fix it please
> tell me,thanks.

Use current code and current documentation.

See ftp://ftp.denx.de/pub/RTAI/README

> [root@banana rtai-24.1.12]# make

Don't use rtai-24.1.12 any  more,  it's  too  old.  We  support  RTAI
version 3.0r5 (kilauea) and 24.1.13 (stromboli); see the README.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If all the Chinese simultaneously jumped into the Pacific  off  a  10
foot platform erected 10 feet off their coast, it would cause a tidal
wave that would destroy everything in this country west of Nebraska.
