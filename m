Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 4276DDE154
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 03:34:43 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so313239uge.0
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 10:34:41 -0700 (PDT)
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 4/5] LED driver
References: <20080412134831.424480cf@lappy.seanm.ca>
	<20080412141039.25e14fae@lappy.seanm.ca>
	<87r6daym53.fsf@macbook.be.48ers.dk>
	<20080413125119.6bb54a29@lappy.seanm.ca>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Sun, 13 Apr 2008 19:34:38 +0200
In-Reply-To: <20080413125119.6bb54a29@lappy.seanm.ca> (Sean MacLennan's
	message of "Sun\, 13 Apr 2008 12\:51\:19 -0400")
Message-ID: <87hce5zmj5.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Sean" == Sean MacLennan <smaclennan@pikatech.com> writes:

 >> How about getting gpiolib working and use leds-gpio.c instead?

 Sean> Actually, I was going to just ask about that... how close is leds-gpio
 Sean> to being working, and will it be in 2.6.26?

I haven't actually used leds-gpio, but it looks so simple that I
cannot imagine it not working. There also seems to be quite some
platforms using it, E.G:

% git grep '"leds-gpio"' arch|wc -l
11

Or are you referring to the status of gpiolib support on powerpc?

-- 
Bye, Peter Korsgaard
