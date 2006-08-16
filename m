Return-Path: <dan@embeddedalley.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id 83F8D679E7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Aug 2006 01:49:09 +1000 (EST)
In-Reply-To: <20060815195203.37918.qmail@web32106.mail.mud.yahoo.com>
References: <20060815195203.37918.qmail@web32106.mail.mud.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E959C2A9-7863-48C0-B2A7-4BB1BB898F2A@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: CPM2 UARTs: Won't work under low (<= 1200BD) baudrates?
Date: Wed, 16 Aug 2006 11:42:19 -0400
To: David Tao <david_xtao@yahoo.com>
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


On Aug 15, 2006, at 3:52 PM, David Tao wrote:

> Under 2400 baud or above the UARTs work fine, but once the baudrate  
> set to 1200 or below, there is NO data can be sent out or received  
> even programed to do so.

It doesn't look like we check the baud rate and
add the preceding divide-by-16 clock for the
low baud rates like we did on the original CPM.
You can add this, test it, and submit a patch if
you like :-)

Thanks.

	-- Dan
