Message-ID: <40EBB6E8.6020104@246tNt.com>
Date: Wed, 07 Jul 2004 10:40:08 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Linh Dang <linhd@nortelnetworks.com>
Cc: ppc linux embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Getting rid of static IO mapping
References: <40EB28C7.5020105@246tNt.com> <wn5isd0jwn3.fsf@linhd-2.ca.nortel.com>
In-Reply-To: <wn5isd0jwn3.fsf@linhd-2.ca.nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Linh Dang wrote:

>On 6 Jul 2004, tnt@246tnt.com wrote:
>[...]
>
>
>>I wonder how it works. At the mapin_ram(), my BAT are overwritten,
>>
>>
>
>No they're not. the BAT configurations (which will be used later by
>load_up_mmu) are written, NOT the BATs themselves.
>
>
>
Ok, thanks. That's what I've missed.

>>then the "MMU:setio" progress is called, but at this point, my BAT
>>is no longer active and my setup_io_mappings is not yet
>>called. Shouldn't that crash ? During these two calls, the uart zone
>>shouldn't be mapped.
>>
>>
>
>setup_io_mappings is similar to mapin_ram. the configurations are
>changed but not the BATs.
>
>


Sylvain Munaut

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
