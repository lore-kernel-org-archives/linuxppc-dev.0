To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: more questions about 8xx microcode patches 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 27 Jul 2004 17:36:26 EDT."
             <Pine.LNX.4.60.0407271733200.7504@localhost.localdomain>
Date: Wed, 28 Jul 2004 00:30:28 +0200
Message-Id: <20040727223033.79CE4C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.60.0407271733200.7504@localhost.localdomain> you wrote:
>
> > Hahahahaha!!!!  You don't know how big of a hole you are digging :-)
>
> oh, fer shure.  :-)  but given that there are three clear and
> identifiable patches that exist at the moment, i'll put together a
> patch that turns them into a submenu and submit it, and you can decide
> what to do with it.  i'll make sure that the submission doesn't change
> any of the current functionality, just makes it easier to pick what
> you want.

Just to add to the complexity: are you aware that the  parameter  RAM
relocation  may  be  different between 8xx processors? For example it
seems that on the 866 family  you  can  relocate  PRAM  even  without
loading any uCode by just writing the correct offset to (for example)
the spi_rpbase register.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Substitute "damn" every time you're inclined to write "very"; your
editor will delete it and the writing will be just as it should be.
                - Mark Twain

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
