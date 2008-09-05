Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E881BDE087
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 07:53:30 +1000 (EST)
Date: Sat, 6 Sep 2008 01:53:27 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH] powerpc: gpio driver for mpc831x/834x/837x with OF
	bindings
Message-ID: <20080905215327.GA8061@oksana.dev.rtsoft.ru>
References: <1220627327-28852-1-git-send-email-jacmet@sunsite.dk>
	<20080905161607.GA10826@oksana.dev.rtsoft.ru>
	<87tzcuctyq.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <87tzcuctyq.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 05, 2008 at 08:45:33PM +0200, Peter Korsgaard wrote:
> >>>>> "Anton" == Anton Vorontsov <avorontsov@ru.mvista.com> writes:
> 
>  Anton> On Fri, Sep 05, 2008 at 05:08:47PM +0200, Peter Korsgaard wrote:
>  >> Structured similar to the existing QE GPIO support.
>  >> 
>  >> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
>  >> ---
> 
>  Anton> I posted identical driver in June. ;-)
> 
>  Anton> http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057395.html
> 
> Ahh, I must have missed it back then. Seems like you never got any
> feedback on it - Now, as we both independently got to ~same result, it
> must be a good approach ;) Kumar, what do you say?
> 
> >From a quick look, your driver seems to set the data / direction
> registers in the wrong order in fsl_gpio_dir_out causing a glitch with
> high level outputs:
> 
> http://peter.korsgaard.com/patches/uboot/mpc83xx-gpio-level-before-direction.patch
> 
> (Never seems to have made it to the U-Boot list archive, but it's in
> git now).

Yeah, I saw similar patch in the u-boot-users mailing list.
Will incorporate that change, thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
