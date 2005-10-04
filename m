Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 0176F683E3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Oct 2005 01:11:42 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 09EC529EC9
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Oct 2005 17:10:05 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 10368-08 for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Oct 2005 17:10:04 +0200 (CEST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 4729329EC6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Oct 2005 17:10:04 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Tue, 4 Oct 2005 17:11:33 +0200
References: <OF3208D35D.AA3CBB6C-ON48257090.0019F4B3@uk.marconicomms.com>
In-Reply-To: <OF3208D35D.AA3CBB6C-ON48257090.0019F4B3@uk.marconicomms.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510041711.34388.david.jander@protonic.nl>
Subject: Re: serial console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 04 October 2005 08:54, KokHow Teh wrote:
> Hi;
>       I have debian linux running on my PQ2FADS-ZU with devfs and serial
> driver compiled in. I have read Documentation/serial-console.txt and I have
> tried both passing "console=" option as well as without passing that to the
> kernel and both don't give me the expected results.
>       When I pass "console=tts/0,115200n8" to the kernel, I don't get any
> console output until the login prompt which I set to 115200 in
> /etc/inittab. When I don't pass "console=" option to the kernel, I get
> console output all the way until "Freeing unused kernel memory:" and the
> console output is garbled and I don't see any login prompt. Here is the
> /dev/* content:

I don't know exactly what I am talking about right now, but the string "tts/0" 
in the console-line sounds suspicious to me. AFAIK when using devfs still 
device names on the kernel-commandline have to be old-style.
Just a guess: try using "console=ttyS0,115200n8" and see if this helps.

Greetings,

-- 
David Jander
