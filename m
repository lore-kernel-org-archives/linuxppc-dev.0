To: Roland Dreier <roland@topspin.com>
Cc: Eli Brin <elib@rokonet.co.il>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: openssl 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "12 Mar 2003 08:55:40 PST."
             <52r89cwmlv.fsf@topspin.com>
Date: Wed, 12 Mar 2003 20:47:03 +0100
Message-Id: <20030312194708.DCEABC58BB@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <52r89cwmlv.fsf@topspin.com> you wrote:
>
>     Eli> We don't have the /dev/random and /dev/urandom. How do we
>     Eli> create them - mknod?
>
> Yes,
>
>   mknod /dev/random  c 1 8
>   mknod /dev/urandom c 1 9
>
> is all you need to do.

Umm... maybe. Note that you might end up waiting for a LONG  time  to
get any data out of /dev/random...


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
PLEASE NOTE: Some Quantum Physics Theories Suggest That When the Con-
sumer Is Not Directly Observing This Product, It May Cease  to  Exist
or Will Exist Only in a Vague and Undetermined State.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
