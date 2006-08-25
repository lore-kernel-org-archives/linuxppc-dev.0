Return-Path: <dan@embeddedalley.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id 76B7667C5F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Aug 2006 05:33:02 +1000 (EST)
In-Reply-To: <Pine.WNT.4.61.0608251400100.200@holyoke.labs.mot.com>
References: <DADA32856852FC458E0F96B664A6F55E011E2425@kom-mailsrv1.kontron-modular.com>
	<Pine.WNT.4.61.0608251400100.200@holyoke.labs.mot.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <561D5B15-7033-4231-BF61-DC4BEEA52CF2@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: "ip=" command line strangeness...
Date: Fri, 25 Aug 2006 15:32:59 -0400
To: T Ziomek <ctz001@email.mot.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 25, 2006, at 3:18 PM, T Ziomek wrote:

>> please provide the ip-commandline in the full-size format
>> ip=<my ip>:<server ip>:<host ip>:<net mask>:<hostname>:<which  
>> ethernet port, e.g. "eth0">
>
> The port should be followed by ":<autoconf>", right?  I'm basing  
> that on
> Documentation/nfsroot.txt .

Documentation is out of date.  After the port number should be
one of:
	off | none
	on | any
	dhcp | bootp | rarp
	both

I usually use 'on' or 'any' to cause the autoconfig to happen.

> Meh...that string is so bloody long I don't want to bother trying  
> it since
> I know that "ip=<my IP>:gibberish" works well enough...

If you run a dhcp server (which I do), all you need is 'ip=any'.
If you are really doing the configuration with all of those options
on the command line, you have to use 'off' after the port
identifier or it will try to contact a server using one of the
configured protocols (dhcp, bootp. rarp) to get the information.


	-- Dan
