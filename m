Return-Path: <dan@embeddedalley.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id F031B68679
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 02:56:29 +1100 (EST)
In-Reply-To: <F6AD7E21CDF4E145A44F61F43EE6D9393FD5A2@tmnt04.transmode.se>
References: <F6AD7E21CDF4E145A44F61F43EE6D9393FD5A2@tmnt04.transmode.se>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a144cb5305133b4a5c38afc2a432c62d@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Date: Mon, 7 Nov 2005 11:02:42 -0500
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 7, 2005, at 9:32 AM, Joakim Tjernlund wrote:

> This is one reason why it is the way it is:

Oh geeze, what a hack!  :-)  This could have been fixed
with a line of assembler code in the TLB miss exception.
I'll take a look at all of this and fix it up.

Thanks.

	-- Dan
