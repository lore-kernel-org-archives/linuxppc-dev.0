To: "Mark Chambers" <markc@mail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: JTAG debuggers for Motorola 8xx/82xx/85xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 18 Jun 2004 09:09:49 EDT."
             <001501c45535$8aecd120$0301a8c0@chuck2>
Date: Fri, 18 Jun 2004 17:04:55 +0200
Message-Id: <20040618150500.73631C13D3@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <001501c45535$8aecd120$0301a8c0@chuck2> you wrote:
> Thanks for this information Wolfgang.  We've been trying to decide between
> 5200 and an 8xxx for a project and have gotten the distinct feeling that
> 5200 is somehow not from the same part of the company as 8xxx, and not
> supported in the same way.  Do you know, do the 82xx or 85xx processors have
> similar restrictions?

The same restrictions are in place for all processors with a JTAG/COP
port, i. e. all what's ther eis in the 52xx, 82xx, 85xx,  7xx,  74xx,
... families. Just the 5xx/8xx which use BDM are an exception.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
No user-servicable parts inside. Refer to qualified service personnel.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
