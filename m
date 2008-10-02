Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id A286EDDE1C
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 21:56:18 +1000 (EST)
Received: by gxk14 with SMTP id 14so1421992gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Oct 2008 04:56:17 -0700 (PDT)
Date: Thu, 2 Oct 2008 07:55:07 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH v2] ibm_newemac: Add support for GPCS, SGMII
	andM88E1112 PHY
Message-ID: <20081002115507.GB2227@yoda.jdub.homelinux.org>
References: <1222929477-10329-1-git-send-email-vgallardo@amcc.com>
	<1222929920.12264.96.camel@pasglop>
	<0CA0A16855646F4FA96D25A158E299D602C81377@SDCEXCHANGE01.ad.amcc.com>
	<1222932759.12264.104.camel@pasglop>
	<20081002063320.7b2331b4@zod.rchland.ibm.com>
	<1222943668.12264.106.camel@pasglop>
	<20081002065648.285cce25@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081002065648.285cce25@zod.rchland.ibm.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Victor Gallardo <vgallardo@amcc.com>,
	Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 02, 2008 at 06:56:48AM -0400, Josh Boyer wrote:
>> > > Jeff, can we merge all those EMAC patches via the powerpc git ? need an
>> > > ack from you I suppose ...
>> > 
>> > I already have this in my tree.  Jeff already acked it (twice now I
>> > think).
>> > 
>> > http://git.kernel.org/?p=linux/kernel/git/jwboyer/powerpc-4xx.git;a=shortlog;h=next
>> 
>> Ok so it will go in when I get your pull request then :-0
>
>Yep.  You could pull now if you'd like.  I have a few more patches I'd
>like to get in before the merge window, but if it helps things I can do
>those in a separate pull request.

Actually, it seems not.  I pulled in an older version of the patch.  I'll
grab the new version today.

/me sighs.

josh
