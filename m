To: "Rupesh S" <rupeshs@myw.ltindia.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Does ext2 based on MTD acceptable for Embedded Development? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 30 Aug 2004 12:26:11 +0530."
             <s1331f30.037@EMAIL>
Date: Mon, 30 Aug 2004 10:13:19 +0200
Message-Id: <20040830081324.EE84DC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <s1331f30.037@EMAIL> you wrote:
>
> >> Is there an advantage to use ext2 instead of cramfs for read only fs?
>
> > Boot time, as you don't need to uncompress the stuff.
>
> Could you pls elaborate the choice of ex2 in the above scenario, instead of romfs. Was it to take advantage of the features that ext2 provides ?
> Romfs should have had a better bootup time than ext2/jffs2/cramfs.

Are you sure of this? Do you have actual benchmark data?

Also, romfs has some restrictions (owner and permission  information)
and  an  inefficient  design  (pages  read  from filesystem cannot be
executed directly because of 16 byte file header offset).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You see things; and you say ``Why?'' But I dream  things  that  never
were; and I say ``Why not?''
       - George Bernard Shaw _Back to Methuselah_ (1921) pt. 1, act 1

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
