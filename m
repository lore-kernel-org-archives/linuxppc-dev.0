To: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ELDK iso image 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 07 Oct 2002 09:37:30 CDT."
             <0B0A39652BB0D411BCCF00508B9512EC08AEB42C@tx14exm05.ftw.mot.com>
Date: Mon, 07 Oct 2002 17:01:12 +0200
Message-Id: <20021007150117.BD61AFA9C@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Bo,

in message <0B0A39652BB0D411BCCF00508B9512EC08AEB42C@tx14exm05.ftw.mot.com> you wrote:
>
> Would you please provide the ELDK iso image (instead of directory tree)
> on your web address: www.denx.de or ftp.leo.org ?

No, I won't ;-)

> Basically there are a lot of problems for me (perhaps others) to burn the
> image on linux box.

Well, you always have the option to buy the CDROM if you don't manage
to burn one yourself.


The main reason not to provide an ISO image whas that we expected our
first release of the ELDK to require lots of updates. Actually,  this
was not really necessary.


But it makes little sense to put ISO images out anyway:

We will have a new version of the ELDK (based on YD-2.3)  out  before
the  end  of  the  month.  Even then, we will not provide ISO images.
Instead, we intend to use Debian's "jigdo"  mechanism  to  allow  for
easy creatsion of ISO images on the user side and easy updates on the
developer's side.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Man is the best computer we can put aboard a spacecraft ...  and  the
only one that can be mass produced with unskilled labor.
                                                  - Wernher von Braun

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
