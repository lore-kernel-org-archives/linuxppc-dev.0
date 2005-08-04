Return-Path: <bob@acdstar.com>
Received: from mail.acdstar.com (mail.acdstar.com [209.98.244.9])
	by ozlabs.org (Postfix) with ESMTP id 6D69D67DFA
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 23:42:08 +1000 (EST)
Message-Id: <6.2.3.4.1.20050804082815.01ee2e30@mail.int.acdstar.com>
Date: Thu, 04 Aug 2005 08:35:36 -0500
To: achim.machura@berghof.com,
	"Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
From: Bob Peterson <bob@acdstar.com>
In-Reply-To: <00a501c598e6$b7823130$34f1ff0a@beint.local>
References: <00a501c598e6$b7823130$34f1ff0a@beint.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: Re: USB + MPC5200 L25R REV 2 OCT0511C
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Achim and List,

I've recently been doing some experiments regards USB on our custom
icecube-like mpc5200 board using the usb-ohci driver, and here's what I found:

1. Some devices (high speed?) seem to work fine.  I used a USB jump drive.
2. Other devices (low speed?) like USB keyboard and mouse did not.
3. Plugging a USB hub into the board allows the same failing devices
     (kbd & mouse) to work properly (when they are plugged into the hub).
4. The off-the-shelf icecube board behaves the same way, so it's not just our
     board.

I haven't tried to backtrack this because USB isn't a major aspect of 
our product
and I've got higher priorities.

Regards,

Bob Peterson
Advanced Communication Design
(952) 854-4000

At 06:21 AM 8/4/2005, Achim Machura wrote:
>Helo list,
>
>do everybody know about problems with usb (usb-ohci) and MPC5200 label  L25R
>REV 2 OCT0511C.
>
>When i plugg in a usb-device, i see that the kernel will assign an address
>to the device, but it failed by timeout.
>
>The same kernel an the same usb-device works fine on a board with a cpu
>label 0L25R QAH0410
>
>best regards
>
>Achim
>
>____________________________________________
>Achim Machura Softwareentwicklung
>Berghof Automationstechnik GmbH
>Harretstrasse 1, D-72800 Eningen u.A.
>Tel: +49-7121-894-131, Fax: +49-7121-894-100
>email: machura@berghof.com
>Internet: http://www.berghof.com
>
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
