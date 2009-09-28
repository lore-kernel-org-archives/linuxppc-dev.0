Return-Path: <jacmet@gmail.com>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147])
	by ozlabs.org (Postfix) with ESMTP id E9BC8B7BEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Sep 2009 15:17:00 +1000 (EST)
Received: by ey-out-1920.google.com with SMTP id 3so727251eyh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Sep 2009 22:16:57 -0700 (PDT)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: Johnny Hung <johnny.hacking@gmail.com>
Subject: Re: GPIO driver for MPC8313.
References: <cb9ecdfa0909222055x1d691698sb516b5b8f5f81d@mail.gmail.com>
	<87y6o6rvvc.fsf@macbook.be.48ers.dk>
	<cb9ecdfa0909230352w77a37f59h3c7f1e146121f9f6@mail.gmail.com>
	<87r5txrkfz.fsf@macbook.be.48ers.dk>
	<cb9ecdfa0909230820k6ebbd589o409e58e2d9b6740c@mail.gmail.com>
	<cb9ecdfa0909271943o6133f5c8r9b25a25140e7842f@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 28 Sep 2009 07:16:55 +0200
In-Reply-To: <cb9ecdfa0909271943o6133f5c8r9b25a25140e7842f@mail.gmail.com>
	(Johnny Hung's message of "Mon\, 28 Sep 2009 10\:43\:00 +0800")
Message-ID: <87vdj3sl6g.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Johnny" == Johnny Hung <johnny.hacking@gmail.com> writes:

 Johnny> The kerne source I used now is 2.6.23 with MPC8313-erdb
 Johnny> pached. I think I should port 2.6.28 gpio function back to
 Johnny> 2.6.23. Is it a common way to implement it in the kernel I used
 Johnny> or I should port MPC8313-erdb pached to 2.6.28 opposite?

It shouldn't be that hard to back port, but I would certainly go for
2.6.28 (or rather 2.6.31) unless something keeps you at 2.6.23.

-- 
Bye, Peter Korsgaard
