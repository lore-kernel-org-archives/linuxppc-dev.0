To: Kate Alhola <kate@iti.fi>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Lite5200 PCI not working 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 21 Jun 2004 17:12:00 +0300."
             <40D6ECB0.6040301@iti.fi>
Date: Mon, 21 Jun 2004 17:14:35 +0200
Message-Id: <20040621151440.DEA80C13D3@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Kate,

in message <40D6ECB0.6040301@iti.fi> you wrote:
>
> Small notice about Coral-P card. Least one that i have needs separate -12V to connec to PCI
> connector pins. There is no -12V supply on board. The Coral-P does itself  need
> -12V but there is one analog mux in video output that needs -5V that is
> generated from -12V.

Are you really sure? Maybe it was just an issue of finding the  right
jumper  settings (which is non-trivial). We tested both with Rev. 4.0
and Rev. 5.0 cards, and didn't need -12V.

> It  looks a like that wery ccommon problem is that many board needs some +/-12V
> event thay should not.

There are worse things; I toasted a LITE5200 with a simple 2x  serial
card  which claims to be a Multi Voltage card but routes +5V on V_I/O
...

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Conscious is when you are aware of something, and conscience is  when
you wish you weren't.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
