Return-Path: <dan@embeddedalley.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id 6CB3F68A20
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Jan 2006 08:54:34 +1100 (EST)
In-Reply-To: <ITVFT5$D7FAA0BB780EC8B8F02A50A5AB92E2E0@libero.it>
References: <ITVFT5$D7FAA0BB780EC8B8F02A50A5AB92E2E0@libero.it>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <53035e2c9b2c98da1fa34788a7079697@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: MPC875 porting
Date: Sun, 29 Jan 2006 16:47:51 -0500
To: "dibacco\@inwind\.it" <dibacco@inwind.it>
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


On Jan 29, 2006, at 3:34 PM, dibacco@@inwind..it wrote:

> I have a custom board with a MPC875 and two ethernet ports. I think I 
> need to modify the enet.c to have two ethernet ports working.

Please read the archives and use the new drivers/net/fs_net
driver and the new serial port drivers.  This has all been updated
and should just work for you.

Thanks.

	-- Dan
