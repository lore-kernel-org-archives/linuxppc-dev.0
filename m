To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linh Dang <linhd@nortelnetworks.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: list of 2.6-related migration issues for embedded programmers? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 19 Jul 2004 13:51:57 EDT."
             <Pine.LNX.4.60.0407191350320.23725@dell.enoriver.com>
Date: Mon, 19 Jul 2004 22:58:30 +0200
Message-Id: <20040719205835.AA851C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.60.0407191350320.23725@dell.enoriver.com> you wrote:
>
> > initramfs is convenient. you don't need root access nor special tools
> > to create the root-fs. it very easy when you want to
> > version-controlled you root-fs.
>
> ah, that would be convenient since, as it is, i'm using a hacked
> version of "genext2fs" that allows me to create the initial root fs as
> a regular user.  i *definitely* have to look into initramfs, then.

What do you mean with "hacked"? Standard  "genext2fs"  will  do  this
just fine.

And as usual, there is two sides to initramfs. It may  be  convenient
for some cases, where you can use the very same root filesystem image
bundled  with the kernel image, but exactly thsi convenience may hurt
you in other cases where it's much better  when  you  have  separated
images which can be updated independently of each other.

Speaking for myself: I don't see advantages in it. None.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I used to be indecisive, now I'm not sure.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
