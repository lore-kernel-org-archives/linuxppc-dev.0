Return-Path: <jacmet@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.24])
	by ozlabs.org (Postfix) with ESMTP id 373B3DDFC7
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 04:45:39 +1000 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so218032eyi.15
	for <linuxppc-dev@ozlabs.org>; Fri, 05 Sep 2008 11:45:37 -0700 (PDT)
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] powerpc: gpio driver for mpc831x/834x/837x with OF
	bindings
References: <1220627327-28852-1-git-send-email-jacmet@sunsite.dk>
	<20080905161607.GA10826@oksana.dev.rtsoft.ru>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Fri, 05 Sep 2008 20:45:33 +0200
In-Reply-To: <20080905161607.GA10826@oksana.dev.rtsoft.ru> (Anton Vorontsov's
	message of "Fri\, 5 Sep 2008 20\:16\:07 +0400")
Message-ID: <87tzcuctyq.fsf@macbook.be.48ers.dk>
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

>>>>> "Anton" == Anton Vorontsov <avorontsov@ru.mvista.com> writes:

 Anton> On Fri, Sep 05, 2008 at 05:08:47PM +0200, Peter Korsgaard wrote:
 >> Structured similar to the existing QE GPIO support.
 >> 
 >> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
 >> ---

 Anton> I posted identical driver in June. ;-)

 Anton> http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057395.html

Ahh, I must have missed it back then. Seems like you never got any
feedback on it - Now, as we both independently got to ~same result, it
must be a good approach ;) Kumar, what do you say?

>From a quick look, your driver seems to set the data / direction
registers in the wrong order in fsl_gpio_dir_out causing a glitch with
high level outputs:

http://peter.korsgaard.com/patches/uboot/mpc83xx-gpio-level-before-direction.patch

(Never seems to have made it to the U-Boot list archive, but it's in
git now).

-- 
Bye, Peter Korsgaard
