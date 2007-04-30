Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0318BDDF04
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 06:49:31 +1000 (EST)
To: Eberhard Stoll <eberhard.stoll@berghof.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC5200 ethernet communication stops unexpected 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 27 Apr 2007 19:09:19 +0200."
	<46322E3F.8050508@berghof.com>
Date: Mon, 30 Apr 2007 22:49:33 +0200
Sender: wd@denx.de
Message-Id: <20070430204933.308A93525D5@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <46322E3F.8050508@berghof.com> you wrote:
>
> It seems that this fault only occurs if the ping is done thru a telnet 
> session. Logging into the controller on the serial console and doing the 
> pings won't trigger the fault (at least not so fast). This might be a 

According to our experience, it's actually not the "ping" which is
triggering the problem, but the telnet output you see (i. e. TCP/IP
traffic).

You will probaly see the same  behaviour  by  running  someting  like
"telnet  target_ip  chargen  >/dev/null"  instead  of  the flood ping
(assuming you have enabled the chargen service on the target.

> If i do a 'ping -f 10.255.226.71 > /dev/null', which suppresses the 
> output now run for hours ...

See above.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,    CEO: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Bradley's Bromide: If computers get too  powerful,  we  can  organize
them into a committee - that will do them in.
