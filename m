In-Reply-To: <Pine.GSO.4.21.0311122039580.1561-100000@waterleaf.sonytel.be>
References: <Pine.GSO.4.21.0311122039580.1561-100000@waterleaf.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v606)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <55821B76-1669-11D8-A264-000393DBC2E8@motorola.com>
Cc: Tom Rini <trini@kernel.crashing.org>, Wolfgang Denk <wd@denx.de>,
	Dale Farnsworth <dale@farnsworth.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Gabriel Paubert <paubert@iram.es>
From: Kumar Gala <kumar.gala@motorola.com>
Subject: Re: MPC5200 Patches
Date: Fri, 14 Nov 2003 00:11:06 -0600
To: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


What about a single i2c-mpc.c that handles 10x/824x/85xx/5xxx since
they all seem to support the same programming model from what I can
tell (5xxx seems not to support broadcast).  This would cover all
non-CPM instances of I2C on Motorola PPC parts.

- kumar

On Nov 12, 2003, at 1:41 PM, Geert Uytterhoeven wrote:
>
> On Wed, 12 Nov 2003, Gabriel Paubert wrote:
>> On Wed, Nov 12, 2003 at 03:45:14PM +0100, Wolfgang Denk wrote:
>>> In message <20031112114114.GA8526@iram.es> you wrote:
>>>>> i2c-algo-m5xxx.c, like the original?
>>>>
>>>> Hmmm, dont't repeated x have a tendency to trigger spam filters
>>>> (especially the dumbest ones)?
>>>
>>> Who cares? This is Linux kernel source code.
>>
>> I don't remeber the details, but I believe that some people had
>> problems when posting about the aic7xxx driver some time ago. And
>> yes, this was on the linux kernel mailing list IIRC.
>
> Yep. But IIRC the problem was not posting, but receiving. Apparently
> some people subscribed to lkml are behind corporate spam filters that
> remove everything that contains `xxx'. So people started to talk about
> the aic7<censored> driver to fool the spam filters.
>
> BTW, there are similar problems with accessing the Video4Linux
> website, hosted at bytesex.org.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
