Date: Tue, 4 Jun 2002 16:34:23 -0500
Subject: Re: pt_regs.dbcr0/1
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v481)
Cc: Paul Mackerras <paulus@samba.org>,
	<linuxppc-embedded@lists.linuxppc.org>
To: Dan Malek <dan@embeddededge.com>
From: Kumar Gala <kumar.gala@motorola.com>
In-Reply-To: <3CFCF745.8090002@embeddededge.com>
Message-Id: <D68E7052-7802-11D6-B64C-003065BFB10E@motorola.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am not seeing where the other debug registers that are associated with
the debug state are being state changed and managed.  For example
IAC{1-4} [breakpnt], DACs [watchpnts], DVCs are being handled.

The 4xx debug hardware looks to be similar to what is spec'd in Book-E.
If this solution is not solved at this time it will come up in the
future with new Book-E parts coming down the pipes.

- kumar

On Tuesday, June 4, 2002, at 12:22 PM, Dan Malek wrote:

>
> Paul Mackerras wrote:
>
>> So has anyone done a 4xx-aware gdb yet?
>
> Not to my knowledge.  Daniel Jacobowitz (drow) has discussed it a
> little,
> but I have not heard much about it lately.
>
>> ....  I think we are in violent agreement. :)
>
> Not again......It must be that Aussie English :-)
>
>
>> ..... gdb + xmon/kgdb
>> may be possible but we will have to see how complex it looks once we
>> know what the kernel support for gdb looks like.
>
> I believe we have tied the BDI context switch configuration option to
> allowing external debugging by ensuring the kernel doesn't mess around
> with the debug registers.  We have at least discussed doing it.  As
> long as we properly context switch the debug registers, all of the
> software
> modes should coexist happily.
>
> Thanks.
>
>
> 	-- Dan
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
