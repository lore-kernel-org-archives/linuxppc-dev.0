Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 7D03BDDF58
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 02:00:04 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so717775anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 05 May 2008 08:59:59 -0700 (PDT)
Message-ID: <fa686aa40805050859u60586a41w53c62be5eb595eab@mail.gmail.com>
Date: Mon, 5 May 2008 09:59:59 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sascha Hauer" <s.hauer@pengutronix.de>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] add Phytec pcm030 board support
In-Reply-To: <20080505011607.GA9349@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080425134805.GP6692@pengutronix.de>
	<20080505011607.GA9349@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, May 4, 2008 at 7:16 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Fri, Apr 25, 2008 at 03:48:05PM +0200, Sascha Hauer wrote:
>  > Add board support for the Phytec pcm030 mpc5200b based board. It
>  > does not need any platform specific fixups and as such is handled
>  > as a mpc5200 simple platform.
>
>  Those still whingeing about how horrible and hard and tedious the new
>  world of device trees is, take note.  We've certainly had some
>  teething problems as we all figure out how to use the device tree
>  properly.  But this is the payoff: support for a new board added with
>  one text file.  It's only going to get more common.

/me hands David a beer.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
