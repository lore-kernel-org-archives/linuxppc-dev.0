Message-ID: <3B81668F.7B5ED936@mvista.com>
Date: Mon, 20 Aug 2001 15:35:43 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: John Francis <johnfrancsis@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using IDMA1 ( or IDMA2 ) on 860
References: <20010820191655.27820.qmail@web20105.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John Francis wrote:

> ..... if I have a pointer that is returned
> by doing ioremap_noncache() if I want to assign this
> pointer in buffer descriptor setup should i be doing
> __pa () correct?

No, that won't work.  You will have to keep the original
physical address around someplace and use it when necessary.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
