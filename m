Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id BEAE267BB1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 23:10:15 +1000 (EST)
Message-ID: <451D1B34.5070306@ru.mvista.com>
Date: Fri, 29 Sep 2006 17:10:12 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Subject: Re: Support for Linux Trace Tool (ltt)
References: <F795765B112E7344AF36AA911279641502D19C99@xmb-sjc-212.amer.cisco.com>
In-Reply-To: <F795765B112E7344AF36AA911279641502D19C99@xmb-sjc-212.amer.cisco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ltt-dev@listserv.shafik.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

Bizhan Gholikhamseh (bgholikh) wrote:

> Hi All,
> Is there any support for Linux ltt on Linux 2.6 (perfably 2.6.11) for
> ppc architecture (MPC8541E)?

    Yes but this is the wrong list to ask. Look into 
http://ltt.polymtl.ca/ltt-patches/ -- there you should be able to find LTT 
with added specific MPC85xx support (as well as my other things fixed/added). 
I assume these have been carried into LTTng project as well (which is hosted 
on http://ltt.polymtl.ca/).

> Thanks,
> BG

WBR, Sergei
