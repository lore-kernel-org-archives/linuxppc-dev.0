Message-ID: <3F3CFE7B.9060200@devcom.cz>
Date: Fri, 15 Aug 2003 17:38:35 +0200
From: Jan Damborsky <jan.damborsky@devcom.cz>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Ethernets on SCC2 and SCC3 on mpc8xx
References: <20030813164727.97DFBC59E4@atlas.denx.de> <3F3B2C84.7020506@devcom.cz> <3F3BBCED.7060304@embeddededge.com>
In-Reply-To: <3F3BBCED.7060304@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:

> Attached is a patch for an old driver that I have given to many
> people over the past couple of years that all promised they would
> update the current source.  This never happened, so if anyone else
> wants to try, have at it.
>
> I don't like this patch due to the amount of code in the header
> file that can only increase as more boards are added.  Please
> remove this code and place it int some file, like enet_init.c or
> something like that.
>
Thank you. I will apply this patch as soon as I return from
holiday in September.
                                     Jan Damborsky


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
