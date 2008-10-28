Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.228])
	by ozlabs.org (Postfix) with ESMTP id 158A5DDEE1
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 04:40:55 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2630324rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 10:40:54 -0700 (PDT)
Message-ID: <fa686aa40810281040s376557f7ucdaa4ae094611bf1@mail.gmail.com>
Date: Tue, 28 Oct 2008 11:40:54 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 1/4] of_gpio: Return GPIO flags from of_get_gpio()
In-Reply-To: <20081028165623.GA6686@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.64.0810241442240.3790@t2.domain.actdsltmp>
	<1224889741-4167-1-git-send-email-tpiepho@freescale.com>
	<20081028143933.GA18453@oksana.dev.rtsoft.ru>
	<fa686aa40810280753lc555683y5d32da678384438@mail.gmail.com>
	<20081028151659.GA26444@oksana.dev.rtsoft.ru>
	<fa686aa40810280842t36da3998j5f7ad22acf9f582c@mail.gmail.com>
	<20081028165623.GA6686@oksana.dev.rtsoft.ru>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Richard Purdie <rpurdie@rpsys.net>,
	Sean MacLennan <smaclennan@pikatech.com>,
	Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 28, 2008 at 10:56 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Tue, Oct 28, 2008 at 09:42:36AM -0600, Grant Likely wrote:
>> Then we coordinate with Greg and make sure the fixup gets put in place
>> before the window opens; either by bringing the patch in Ben's tree or
>> by getting Greg to pull Ben's tree into -next.  This API change should
>> not block Greg picking up the FHCI driver.  This is not an
>> insurmountable problem.
>
> Sounds complicated.
>
> Ok, but if something will go wrong with the FHCI vs. of_get_gpio()
> change, I'll just attribute the blame to you. :-))

Bring it on.  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
