Return-Path: <dan@embeddedalley.com>
Received: from smtp101.biz.mail.mud.yahoo.com (smtp101.biz.mail.mud.yahoo.com
	[68.142.200.236]) by ozlabs.org (Postfix) with SMTP id 3E2A6DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Jan 2007 14:02:22 +1100 (EST)
In-Reply-To: <200701310254.l0V2sh3L053534@penguin.ncube.com>
References: <200701310254.l0V2sh3L053534@penguin.ncube.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9163DAF8-7756-44DA-B6FF-5B9EC1605B00@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: mmap bug (all archs) w/ fix
Date: Tue, 30 Jan 2007 19:02:32 -0800
To: Michael Galassi <mgalassi@c-cor.com>
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 30, 2007, at 6:54 PM, Michael Galassi wrote:

> When we need to update flash on our system we use a utility which  
> opens
> /dev/mem, mmaps the region of physical memory which contains flash  
> (top
> 128meg), and then does all the ugly magic to erase/write/verify.

MTD does this very nicely for you, and you don't have
to write any special programs......  :-)  It's also much safer.

	-- Dan
