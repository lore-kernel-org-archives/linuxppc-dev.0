Message-ID: <3FD032C1.9060504@intracom.gr>
Date: Fri, 05 Dec 2003 09:24:49 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: the door is closing for 2.4
References: <16334.33020.624995.521330@cargo.ozlabs.ibm.com> <3FCEFB59.80300@intracom.gr> <3FCF3CE0.4020008@embeddededge.com> <3FCF4D78.9000706@intracom.gr> <3FCF540C.3010302@embeddededge.com>
In-Reply-To: <3FCF540C.3010302@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Pantelis Antoniou wrote:
>
>> Once upon a time I had it at least compile, but for my board only.
>> But then you mentioned you were working on it and I dropped it.
>
>
> I had been working on it, primarily to get the processor specific
> changes done.
>
>> Could you please elaborate on the tasks that need to be done?
>> I know that the head_8xx.S file definetely needs alot of work,
>> and you mentioned the drivers.
>
>
> The serial driver doesn't compile since the serial subsystem was
> reworked.  The old data structures used to represent port
> information (in particular serial_state) no longer works.
> Yes, head_8xx.S needs lots of work, but to me that is the easy part :-)

Well if you can get head_8xx.S in some decent shape I can get it to boot
since in a board of mine I don't use the built-in uart but an external
MAX3100.

Do the serial drivers based on the generic_serial interface still work
in 2.6?

>
>
>> What is the minimum stuff needed to make it work at least for my
>> boards?
>
>
> Make it compile again, I'll take it from there.

OK, I'll try (maybe with taking out the 8xx uart out completely).

>
>> I'd be happy to help at least as long as my busy schedule permits.
>
>
> Me, too.  Just don't be annoyed if it takes me a while to respond,
> especially if testing changes is involved.
>
> Thanks.
>
>
>     -- Dan
>
>
>
>
And finally do you think it makes sence to try to consolidate the 8xx
and 82xx drivers?
If we're going to need some major restructuring and/or rewrite of the
drivers that
makes sense IMHO.

Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
