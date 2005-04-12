Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.204])
	by ozlabs.org (Postfix) with ESMTP id 5486767B40
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 13:55:54 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so1393254wri
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 20:55:53 -0700 (PDT)
Message-ID: <9b7ca657050411205576f4618f@mail.gmail.com>
Date: Tue, 12 Apr 2005 12:55:53 +0900
From: Daniel Ann <ktdann@gmail.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <425AC449.4070401@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9b7ca65705040801455b84eb0d@mail.gmail.com>
	<4256CE41.1000404@mvista.com>
	<9b7ca6570504081829cb84a7d@mail.gmail.com>
	<425AC449.4070401@mvista.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Best way to determine tb_ticks_per_jiffy inside
	todc_calibrate_decr()
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

On Apr 12, 2005 3:39 AM, Mark A. Greer <mgreer@mvista.com> wrote:
> Because the internally kept time in ppc linux is based on the
> decrementer counter and, according to the manual for the 8245, the
> decrementer counter is decremented once every four sys_logic_clk
> cycles.  Therefore, you need to divide by 4.

Gotcha. Thanks ^^

-- 
Daniel
