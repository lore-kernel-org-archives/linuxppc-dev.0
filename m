Message-ID: <3CAB41C0.70007@embeddededge.com>
Date: Wed, 03 Apr 2002 12:54:08 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "barry.fisher" <barry.fisher@seranoa.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kgdb support for 8260
References: <000a01c1db25$add3db20$7d0110ac@Seranoa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


barry.fisher wrote:

> More importantly, does anyone know if remote kdgb debugging on the 8260
> is supported.

It was all done in the MontaVista Journeyman kernel.  There was some
discussion about the 4xx version of this, but we should be able to push
those changes for the other PowerPC processors without trouble.

I'll check into it.  I originally wrote all of the code, so if necessary
I can just do it again...........


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
