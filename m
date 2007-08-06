Return-Path: <dan@embeddedalley.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id 23827DDEBA
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Aug 2007 07:19:25 +1000 (EST)
In-Reply-To: <46B743C6.1030905@freescale.com>
References: <200708051854252184131@163.com> <46B743C6.1030905@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A3D38E79-6921-4C9A-BD82-5796B8995BA4@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: my cpu is MPC860, kernel version is 2.6.20.14,
	the kernel start info in the mail. why does the kernel panic?
Date: Mon, 6 Aug 2007 14:12:57 -0700
To: Scott Wood <scottwood@freescale.com>
Cc: poorbeyond <poorbeyond@163.com>,
	Linux-ppc mail list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 6, 2007, at 8:52 AM, Scott Wood wrote:

> It wouldn't surprise me if the 8xx code has issues with PREEMPT; try
> turning it off for now.

What is your reason that 8xx would be any different?

	-- Dan
