Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (sipsolutions.net [66.160.135.76])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 88EA6687C7
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Nov 2005 00:28:00 +1100 (EST)
Message-ID: <60396.131.234.108.27.1132663900.squirrel@secure.sipsolutions.net>
In-Reply-To: <70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net>
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net>
	<70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net>
Date: Tue, 22 Nov 2005 13:51:40 +0100 (CET)
From: "Johannes Berg" <johannes@sipsolutions.net>
To: "Parag Warudkar" <kernel-stuff@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: PowerBook5,8 - TrackPad update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Parag Warudkar wrote:
> Ok, the format interpretation of the trackpad data is taking up more
> of my time and brain than I was happy with! :)

Thanks for sending the data to me, I'll take a look later.

I have doubts, however, about using the appletouch driver, if the format
changed significantly then the code will be largely different.

johannes
