To: lihong wei <lihongwlh@yahoo.com>
Cc: ppclinux <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Serial console failure on DENX Linux on MPC850 board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 18 Dec 2003 10:08:58 PST."
             <20031218180858.55548.qmail@web41902.mail.yahoo.com>
Date: Fri, 19 Dec 2003 21:34:14 +0100
Message-Id: <20031219203419.2CBE5C5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20031218180858.55548.qmail@web41902.mail.yahoo.com> you wrote:
>
> I am porting latest version  Denx linux
> linuxppc_2_4_devel kernel and U-boot 3.0 to our MPC850
>  board. I also used SELF to generate the ext2 file
> system. I am using the TQM850L configuration

If your board is not a TQM850L you should be extremely carefult - you
will most probably need your own set of config options instead.

>  on my board, and configured the SCC2 as serial
> console(because the hardware designed like this).

And your hardware design is most probably different from that of  the
TQM850L< so be careful again.

> I am stuck here and any response will be cordially
> appreciated!

I guess your serial ports are misconfigured.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Here's a fish hangs in the net like a poor man's right in  the  law.
'Twill hardly come out."     - Shakespeare, Pericles, Act II, Scene 1

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
