Message-ID: <3C5ABCAC.9090102@embeddededge.com>
Date: Fri, 01 Feb 2002 11:05:00 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FEC driver multicast patch
References: <6B546A602AD2D211BFF00008C7A4288905843FC6@hrtades2.atea.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Goddeeris Frederic wrote:

> Remember the discussion we had on the multicast support in the FEC-driver?

Yes, and I _strongly_ suggested you not do this.  The SCCs are often allocated
to other uses, and you need a software CRC generator when they aren't available,
so just do it in software and be done with it, please.

Yes, this is a cute thing to do with SCCs, but it doesn't have much use outside
of an academic exercise.

Thanks.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
