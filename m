Mime-Version: 1.0
Message-Id: <v04210102b403c56776f1@[192.168.0.1]>
In-Reply-To: <19990914111817.004706@mailhost.mipsys.com>
References: <19990914111817.004706@mailhost.mipsys.com>
Date: Tue, 14 Sep 1999 01:28:58 -0800
To: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: New booter
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 14/9/99 Benjamin Herrenschmidt wrote:

> >quik is not fixed totally, the first stage loader still does not work
> >on newworld macs, unless anyone has some suggestions...
>
>I agree this is not perfect, but as I wrote you privately, we can still
>use a small HFS partition with the second stage bootstrap beeing directly
>loaded by OF. This works now, I tested it last week. Not perfect, but
>better than BootX for those machine since the kernel will now be able to
>use RTAS ;-)

this would be Ok as a last resort but I do not want to give up on the 
first stage loader just yet!

if only apple's OF were opensource... sigh

BTW i tried loading the second stage loader and it runs but all it 
does is complain that it cannot open disk 0



Best Regards,
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
