Message-ID: <3C1FC9AF.6060204@embeddededge.com>
Date: Tue, 18 Dec 2001 17:56:47 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Navin Boppuri <navin.boppuri@newisys.com>
Cc: Kevin Fry <kevin@carts.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8xx SPI drivers
References: <D3A72C5007329A4F991C0DD87202259F0969FC@sekhmet.ad.newisys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Navin Boppuri wrote:

> I have no website of my own to put this stuff on yet.

Just ask to post it on penguinppc.org.  There is an embedded section
there.....but why do you want to post something like this?  I mean,
we don't post any of the other drivers or code we do anywhere but in
the sources themselves.

> Also, I would like to thank Alex for cleaning up my driver and for
> actually using it.

Keep in mind that SPI designs are very dependent upon the board/product
design.  Many of the systems that use SPI have external hardware for
device selection and control.  The generic driver is suitable for clocking
bits in/out but often isn't sufficient to make everything work.  Due to the
timing of SPISEL, I sometimes had to just write a software bit-toggle function
to make it work.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
