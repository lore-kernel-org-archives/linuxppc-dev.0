Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.195])
	by ozlabs.org (Postfix) with ESMTP id 2DA7C67B14
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 23:05:16 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 71so3916439wra
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 06:05:14 -0700 (PDT)
Message-ID: <9b7ca657050412060556af952e@mail.gmail.com>
Date: Tue, 12 Apr 2005 22:05:14 +0900
From: Daniel Ann <ktdann@gmail.com>
To: Daniel Ann <ktdann@gmail.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20050412122405.GA27920@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9b7ca6570504120138738b554f@mail.gmail.com>
	<20050412122405.GA27920@tuxdriver.com>
Subject: Re: Trying to understand alloc_skb()
Reply-To: Daniel Ann <ktdann@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Apr 12, 2005 9:24 PM, John W. Linville <linville@tuxdriver.com> wrote:
> You may want to consider dev_alloc_skb...

Ahh that's right. I remember reading a little comment on top dev_alloc_skb().
Thank you so much. At least that inspired me :)

Thing is, I got this error during a call to notifier_call_chain. So..
I would have to go thru the functions who is responsible for issueing
alloc_skb directly. Gonna take a little while :P

Cheers,

-- 
Daniel
