Message-ID: <3DF0A4D9.4030603@intracom.gr>
Date: Fri, 06 Dec 2002 15:23:37 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
References: <3DF0A39D.2090401@intracom.gr>
In-Reply-To: <3DF0A39D.2090401@intracom.gr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pantelis Antoniou wrote:

>
> Hi
>
> Can someone tell what is the deal with these functions?

                   ^ me

>
>
> consistent_alloc et. al. are very useful to me now that I'm
> cleaning up my QMC driver. But they are exported.

                                         ^ not

>
>
> Is there any reason why they are not exported for use by
> modules?
>
> Also they appear to be tied to the PCI bus, a reduntant
> dependancy IMHO.
>
> Regards
>
> --
> Pantelis Antoniou
> INTRACOM S.A. Greece
>
> "> I read slashdot because it's so hard to find
> >> anything else intelligent to read.
>
> Keep searching..."
> -- as seen on slashdot --
>
>
>
>

Sigh,

Maybe I should read the mail more before hitting send.




--
Pantelis Antoniou
INTRACOM S.A. Greece

"> I read slashdot because it's so hard to find
>> anything else intelligent to read.

Keep searching..."
-- as seen on slashdot --


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
