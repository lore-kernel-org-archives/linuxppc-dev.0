Message-ID: <3FCF4D78.9000706@intracom.gr>
Date: Thu, 04 Dec 2003 17:06:32 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: the door is closing for 2.4
References: <16334.33020.624995.521330@cargo.ozlabs.ibm.com> <3FCEFB59.80300@intracom.gr> <3FCF3CE0.4020008@embeddededge.com>
In-Reply-To: <3FCF3CE0.4020008@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Pantelis Antoniou wrote:
>
>> However I don't think that 2.6 works for 8xx at all.
>
>
> It doesn't.
>
>> What is the status of 2.6 for 8xx?
>
>
> It's a f'ing mess.
>
>> Does someone intent to do it, or should I try to give it a shot?
>
>
> I intended to do it, but I'm so busy with non-PPC stuff I never
> finshed much of anything.
>
> Right now, it won't even compile because all of the drivers need
> updates, then we need the usual processor dependent porting stuff
> done.  I have a pretty good idea what needs to be done, it's just
> more work than the few weekends I thought it would take.

Once upon a time I had it at least compile, but for my board only.
But then you mentioned you were working on it and I dropped it.

Could you please elaborate on the tasks that need to be done?
I know that the head_8xx.S file definetely needs alot of work,
and you mentioned the drivers.

What is the minimum stuff needed to make it work at least for my
boards?

>
> If someone wants to get the drivers to compile, I'll continue working
> on the processor specific parts and maybe we can get it done soon.

I'd be happy to help at least as long as my busy schedule permits.

>
> Thanks.
>
>
>     -- Dan
>
>
>
Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
