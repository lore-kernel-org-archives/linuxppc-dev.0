Message-ID: <40C428AD.8020707@intracom.gr>
Date: Mon, 07 Jun 2004 11:34:53 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] Take two of the new serial uart driver.
References: <40BF3206.8030705@intracom.gr>	 <1086426744.4588.121.camel@imladris.demon.co.uk>	 <20040605192221.GT15195@smtp.west.cox.net>	 <1086472929.4862.12.camel@localhost.localdomain>	 <40C42337.20209@intracom.gr> <1086597379.29255.13.camel@localhost.localdomain>
In-Reply-To: <1086597379.29255.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Woodhouse wrote:

>On Mon, 2004-06-07 at 11:11 +0300, Pantelis Antoniou wrote:
>
>>David Woodhouse wrote:
>>
>>>VFS: Mounted root (nfs filesystem).
>>>Freeing unused kernel memory: 100k iné
>>>sh-2.05b#
>>>
>
>>The following patch fixes the problem by properly waiting
>>two character times on mode change.
>>
>
>It had to be applied with 'patch -l' due to whitespace noise.
>
>
The patch was against my own tree, so that's explainable.
Should check better next time.

>Now I get this:
>
>VFS: Mounted root (nfs filesystem).
>Freeing unused kernel memory: 100k init
>                                       íbash-2.05b#
>
>
>
Hmm, just multiply by 3 in udelay instead of 2.

What is your baud rate? 9600?

Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
