Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id A85F1DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Sep 2007 04:00:49 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1817574wag
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Sep 2007 11:00:48 -0700 (PDT)
Message-ID: <9e4733910709161100i456c176ay664d89ac638c9958@mail.gmail.com>
Date: Sun, 16 Sep 2007 14:00:48 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: Domen's MPC5200 FEC cleanup patch.
In-Reply-To: <9e4733910709161005u4f400ab7wb1bf55dac1b45193@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910709142038y1bd88cd5s7c9bb21a668db9f6@mail.gmail.com>
	<9e4733910709142128l7a264a05ve68f59aee92b40e3@mail.gmail.com>
	<20070915122218.GB19857@nd47.coderock.org>
	<9e4733910709150855k6ba6dc8fye9762817566208b4@mail.gmail.com>
	<9e4733910709161000i64622520i77caa00e56abc7a8@mail.gmail.com>
	<9e4733910709161005u4f400ab7wb1bf55dac1b45193@mail.gmail.com>
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

Another problem...

Ifconfig eth0 down

hangs the system.
I'll try debugging it.

-- 
Jon Smirl
jonsmirl@gmail.com
