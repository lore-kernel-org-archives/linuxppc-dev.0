To: Jan Damborsky <jan.damborsky@devcom.cz>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC823E SMC/I2C/SPI micropatch 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 26 Jan 2004 11:29:44 +0100."
             <4014EC18.2000303@devcom.cz>
Date: Mon, 26 Jan 2004 12:31:56 +0100
Message-Id: <20040126113201.DBE4CC108D@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <4014EC18.2000303@devcom.cz> you wrote:
>
> >>- it is determined for 850 and 823E processors (I hope).
> >
> > Wrong.
> But I really do not uderstand, why there is following
> sentence in micropatch_850.c file:
>    The patch applicable to the 850 and 823E processors.
> And in micropatch_8xx.c:
>    The patch applicable to all 8xx family except 850 and 823E.
> I think it is rather misleading, is'nt it ?

Yes, it is. Sorry about this. Seems we forgot to update this  comment
in  the linuxppc_2_4_devel tree (it was fixed in the linux-2.4 tree).
Fixed now - thanks for pointing out.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
1st Old Man:  Gee, its windy today.
2nd Old Man:  No it's not... it's Thursday.
3rd Old Man:  Yeh, me too.  Let's go for a beer.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
