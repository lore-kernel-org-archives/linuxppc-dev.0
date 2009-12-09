Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f175.google.com (mail-yw0-f175.google.com
	[209.85.211.175]) by ozlabs.org (Postfix) with ESMTP id B3A3CB6F15
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 00:40:38 +1100 (EST)
Received: by ywh5 with SMTP id 5so7166613ywh.11
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Dec 2009 05:40:34 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B1F6D3A.3030500@pengutronix.de>
References: <fa686aa40911042210q5bbbca2fi82911b7245d17588@mail.gmail.com>
	<4B1F6D3A.3030500@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 9 Dec 2009 06:40:11 -0700
Message-ID: <fa686aa40912090540s1a06c063g10641e90501e8bc1@mail.gmail.com>
Subject: Re: 2.6.33 -next tree
To: Luotao Fu <l.fu@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 9, 2009 at 2:26 AM, Luotao Fu <l.fu@pengutronix.de> wrote:
> Hi Grant,
>
> Grant Likely wrote:
>> Hi Ben, Stephen.
>>
>> I just prepared my next branch for 2.6.33:
>> git://git.secretlab.ca/git/linux-2.6 next
>>
>
> Just for curiosity: I noticed that you keep so far the further patches for the
> dedicated spi controller on mpc5200 in the next-spi tree. Any plan when they
> will be merged to the -next tree? Like mentioned before, some of them are
> essential, without which the driver doesn't work (at least on my board)

I based the next-spi tree on my regular next tree (which was
convenient, but lead to it looking like I had inappropriate stuff in
my spi tree).  Once Ben asks Linus to pull his tree it will all look
correct.  I'll ask Linux to pull my next-spi tree directly after Ben's
tree is in.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
