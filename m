Message-ID: <3E01A1E6.1070905@intracom.gr>
Date: Thu, 19 Dec 2002 12:39:34 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Docs for the new style dpalloc/hostalloc patch.
References: <IGEFJKJNHJDCBKALBJLLEEPCFIAA.joakim.tjernlund@lumentis.se>
In-Reply-To: <IGEFJKJNHJDCBKALBJLLEEPCFIAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

>Hi
>
>This looks good to me. It's only a bit big, but I guess that's the price one
>has to pay. I haven't tested it yet though.
>
>    Jocke
>

Hi

Yes unfortunately is too big, the complexity will pay off
on the upcoming patches, that will allow to use every last bit
of the dpram.

Just enable the options when compiling.
Every current driver that uses the old-style interface
should work without a problem.

I would be very interested to see them used your updated enet driver.

Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
