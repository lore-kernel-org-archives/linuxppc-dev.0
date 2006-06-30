Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 3991567B62
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Jul 2006 06:02:30 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so295847ugf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Jun 2006 13:02:29 -0700 (PDT)
Message-ID: <528646bc0606301302u5922945dycda569e6954fa353@mail.gmail.com>
Date: Fri, 30 Jun 2006 14:02:28 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Ameet Patil" <ammubhai@gmail.com>
Subject: Re: Xilinx SystemACE driver for 2.6
In-Reply-To: <44A580F5.8050900@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <BAY110-F40223AFCCAA679FBC5A962B27D0@phx.gbl>
	<44A580F5.8050900@gmail.com>
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

On 6/30/06, Ameet Patil <ammubhai@gmail.com> wrote:
> Here is PART I of the article:
> http://www.linux.get2knowmore.com/2006/06/30/quick-guide-linux-26-on-xilinx-virtex-ii-pro-boards-part-i/
>
> Let me know if you get messages at boot time after following the above...

Quick comment on your article; unless you're using a microdrive;
*PLEASE* don't recommend using compact flash as swap space.  Flash
technology has limited write cycles (on the order of 100k to 1M cycles
per block).  Using it as swap is a great way to kill the lifecycle of
your device.

(the ML300 ships with a microdrive; the ML40x ships with a regular CF card)

I know the previous article also recommends a swap partition, but
Linux will happily run without swap.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
