Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.202])
	by ozlabs.org (Postfix) with ESMTP id 579B567B40
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 14:03:54 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so1394418wri
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 21:03:53 -0700 (PDT)
Message-ID: <9b7ca65705041121035cb963c@mail.gmail.com>
Date: Tue, 12 Apr 2005 13:03:53 +0900
From: Daniel Ann <ktdann@gmail.com>
To: Grant Likely <glikely@gmail.com>
In-Reply-To: <528646bc050411113074ad93b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <528646bc050411113074ad93b5@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Eliminating RTC from MPC5200
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

On Apr 12, 2005 3:30 AM, Grant Likely <glikely@gmail.com> wrote:
> Is this true?  Can I eliminate the need for the RTC If I modify
> mpc52xx_calibrate_decr() in arch/ppc/syslib/mpc52xx_setup.c and
> mpc52xx_ipbfreq() in arch/ppc/boot/simple/mpc52xx_tty.c?  I'm assuming
> that I can hard code the system clock speeds for my specific hardware.

This kinda relates back to my previous post.
Tho I'm not using mpc52xx, my board doesnt have RTC as well. And I
simply blocked out all the time related functions except the
calibrate_decr. And hard coded the freq.

It works nicely.

BTW, I'm using mpc8245. You should be able to find my post dating back
no more than a week or two. Originally I had trouble working out the
freq, but its all solved thanks to Mark ^^

-- 
Daniel
