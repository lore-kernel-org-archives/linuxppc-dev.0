To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: list of 2.6-related migration issues for embedded programmers? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 19 Jul 2004 17:34:35 EDT."
             <Pine.LNX.4.60.0407191731390.24783@dell.enoriver.com>
Date: Tue, 20 Jul 2004 00:04:25 +0200
Message-Id: <20040719220430.C64FCC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.60.0407191731390.24783@dell.enoriver.com> you wrote:
>
> sadly for me, the version floating around doesn't build FIFOs (even
> though the command-line options suggest it does).  and i need FIFOs to
> support minit.  so i merged a couple different versions to get one
> that handles the extended device file format (erik andersen's??), and
> a small patch to handle FIFOs.

I thought Erik Anderse's version _is_ the standard version these days ;-)

And I thought you were using the ELDK?

> i most likely wouldn't use it for the final build, but it would still
> be more efficient for testing, rather than reflashing the root
> filesystem on the unit every time.  once the image is finalized, then
> i can flash the kernel and rootFS separately.

I can't follow. Why would you flash the  root  filesystem  if  you're
still  testing  it? Just TFTP the test image and use it from RAM (the
kernel may be stored in flash if you like).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Quotation, n. The act of repeating erroneously the words of  another.
The  words  erroneously  repeated.
                            - Ambrose Bierce _The Devil's Dictionary_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
