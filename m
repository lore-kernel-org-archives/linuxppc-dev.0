Message-ID: <3E776A02.9060505@embeddededge.com>
Date: Tue, 18 Mar 2003 13:48:34 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "en_ch@libero.it" <en_ch@libero.it>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem with interrupts handling
References: <HBYCFL$662FE8F3AA02562685A2FED9FE2287DA@libero.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


en_ch@libero.it wrote:

> I think i set correctly all the cpm and siu registers but it doesn't work!!!!!

As I said in a previous e-mail, you are calling these functions
correctly, but there are lots and lots of other configuration
parameters that need to be configured correctly for ATM to work
at all.  I suspect you need to take a look at all of that.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
