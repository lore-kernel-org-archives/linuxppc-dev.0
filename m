To: "Thamarai Selvan" <Thamarai.Selvan@lntinfotech.com>
Cc: "Stephen Williams" <612dlag102@sneakemail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: How Can The Starting Address Of An Image In ELF File BeChanged 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 05 Mar 2004 12:03:55 +0530."
             <OF243EF967.6B4324CF-ON65256E4E.00240CC6@lntinfotech.com>
Date: Fri, 05 Mar 2004 21:40:26 +0100
Message-Id: <20040305204031.8BC71C0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <OF243EF967.6B4324CF-ON65256E4E.00240CC6@lntinfotech.com> you wrote:
>
> can u guide me 2 some document/link on it or brief it little bit more
> why it is linked to that address ?

Because that was the decision of the designers.

> if it is linked it should be configurable
> bcuz iam using vision ice to download my image.

You get this wrong. The layout of the  Linux  kernel  should  not  be
modified  to  try  adapting  it  to any tools - this will fail sooner
orlater. Instead, get tools that are capable of dealing with the task
you put at them.

VisionIce should be usable to download and start thi  image,  but  it
will  probably  be  of  little use after that. Get yourself a BDI2000
instead ;-)

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Inside every old person is a young person wondering what happened.
                              - Terry Pratchett, _Moving Pictures_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
