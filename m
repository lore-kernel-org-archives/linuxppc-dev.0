Return-Path: <dan@embeddedalley.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id B5C3C67A44
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 11:38:02 +1100 (EST)
In-Reply-To: <200511072250.03217.pantelis.antoniou@gmail.com>
References: <200510302203.25390.pantelis.antoniou@gmail.com>
	<20051107084431.GA15180@logos.cnet>
	<1131396000.4652.24.camel@gaston>
	<200511072250.03217.pantelis.antoniou@gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cbe32e9ba3fb8fd6c8d930e7f578369f@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Date: Mon, 7 Nov 2005 19:44:14 -0500
To: pantelis.antoniou@gmail.com
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


On Nov 7, 2005, at 3:50 PM, Pantelis Antoniou wrote:

> Yep. That should be the target. Remember the poor 8xx is not exactly a
> speed demon :).

It really isn't a big speed difference.  The context save/restore
is minimal.  The original thought was " ...well, I'm already here,
I know we will take another exception, so may as well fake the
error case and call do_page_fault."   However, I really do like
a minimal TLB miss case for valid PTEs, and push everything
else to the heavyweight functions.

Thanks.

	-- Dan
