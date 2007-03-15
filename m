Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A1404DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Mar 2007 15:08:14 +1100 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HRhG6-0003lh-I6
	for linuxppc-embedded@ozlabs.org; Wed, 14 Mar 2007 21:08:10 -0700
Message-ID: <9488285.post@talk.nabble.com>
Date: Wed, 14 Mar 2007 21:08:10 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: Re: jffs2-No space left on device
In-Reply-To: <20070314075047.78939352676@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <9469217.post@talk.nabble.com>
	<20070314075047.78939352676@atlas.denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


After unlocking flash partion also i m getting same output.if i use different
flash partition which does not have any readonly area then also i m getting
same output.

Nethra


In message <9469217.post@talk.nabble.com> you wrote:
> 
> Through nfs mounting of root file system.I m trying jffs2 mounting without
> any image( with empty patition).. it is giving 100% of space is used.I m
> getting same output with jffs2 image also.
> what is the actual problem?

The actual problem is that your don't read error messages.

> Erase at 0x002a0000 failed immediately: -EROFS. Is the sector locked?
                                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^

Your file system / partition is read-only, probably because the flash
sectors are locked.

Try unlocking the flash partition before using it.

Best regards,

Wolfgang Denk




-- 
View this message in context: http://www.nabble.com/jffs2-No-space-left-on-device-tf3400453.html#a9488285
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
