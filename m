Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C62A22BD46
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Oct 2004 16:35:34 +1000 (EST)
Date: Tue, 19 Oct 2004 08:34:32 +0200
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20041019083432.01b947d3@pirandello>
In-Reply-To: <1098143379.18687.44.camel@gaston>
References: <20041018232004.0a9e0d5e@jack.colino.net>
	<1098143379.18687.44.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: PMU questions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 19 Oct 2004 at 09h10, Benjamin Herrenschmidt wrote:

Hi Ben, 

thanks for your answer!

> Happens all the time on Apple laptops lately. My tipb battery is now
> half of it's capacity. Browse the archives on the web, you'll see that
> it's a common disease with those.

Ah, nice ("nice") to know... It looks like the more these batteries are
"smart", the faster they get fucked up...

> You can try the following: disable pmud & pbbuttonsd, and let the
> machine on & drain the battery until it shuts down by itself (empty
> battery). Do_not_ let it go to sleep or whatever pmud does when it
> thinks your battery is closed to exhausted. Drain the battery
> completely.

You mean until the laptop shuts down by itself ?

> Then, do a full charge, and drain it again completely. 
> Do that a few times. 

Without resetting the PMU ?

> If that doesn't help, then I'm afraid you have to
> ask apple for a replacement battery.

Yes, I think I'll do this. For the record, I found compatible batteries
a little less pricey than Apple's ones here:
http://store.craytonelectronics.com/apibba2.html  

-- 
Colin
