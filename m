Return-Path: <dan@embeddededge.com>
Received: from smtp005.bizmail.sc5.yahoo.com (smtp005.bizmail.sc5.yahoo.com
	[66.163.175.82]) by ozlabs.org (Postfix) with SMTP id 020302BF07
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Jan 2005 02:39:37 +1100 (EST)
In-Reply-To: <313680C9A886D511A06000204840E1CF0A64743E@whq-msgusr-02.pit.comms.marconi.com>
References: <313680C9A886D511A06000204840E1CF0A64743E@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <92DD848C-5CD3-11D9-80DB-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sun, 2 Jan 2005 10:32:55 -0500
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Cc: 'Jeff Angielski' <jangiels@speakeasy.net>, linuxppc-embedded@ozlabs.org
Subject: Re: inflate returned FFFFFFFD - what does this error exactly mean ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 2, 2005, at 12:58 AM, Povolotsky, Alexander wrote:

> Originally I had relocation address be 0x00400000;
> I also tried 0x00500000 and finally 0x00600000 (shown below)
> - all 3 cases give the same error.
>
>
> loaded at:     00180000 00268160
> relocated to:  00600000 006E8160

You are doing this backward.  You need to load the
image into memory at a higher address like 0x400000.
According to this message, you are loading at 0x180000.
Don't change the relocation address for the build, just
the address where you initially load it into memory.


	-- Dan
