To: Eli Brin <elib@rokonet.co.il>
Cc: "'Jerry Van Baren'" <gerald.vanbaren@smiths-aerospace.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8xx SCC and SMC uart latency 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 15 Jan 2003 14:37:48 +0200."
             <75DF04AC5ED4D511A9810090273CB4163A6726@ROKONET-E>
Date: Wed, 15 Jan 2003 14:11:40 +0100
Message-Id: <20030115131145.29A94C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Eli,

in message <75DF04AC5ED4D511A9810090273CB4163A6726@ROKONET-E> you wrote:
>
> The initial tests where done witout all the parsing and TCP overhead.  We
> just replied imidiatly to packets addressed to us, and we got 5-8mSec delay
> from the last char we received and the first char we send.  Now (HZ=1000)
> it's 2mSec with the parsing and TCP/IP.
>
> Can we leave the HZ to 1000 ?

We cannot answer this question. You know, there is  no  guarantee  in
the  standard  Linux kernel that you will always meet your deadlines.
If an occasional miss is acceptable to you, and the system  works  as
is, then yes, you can leave it as is.

If you  need  guaranteed  deadlines  you  are  in  another  class  of
problems;  you will have to use something like RTAI then. Or maybe at
least the preemptible/low latency patches.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"There is nothing  so  deadly  as  not  to  hold  up  to  people  the
opportunity to do great and wonderful things, if we wish to stimulate
them in an active way."
- Dr. Harold Urey, Nobel Laureate in chemistry

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
