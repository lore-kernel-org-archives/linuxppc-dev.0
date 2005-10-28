Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <43624B30.20600@nortel.com>
References: <17250.8725.358204.62510@cargo.ozlabs.ibm.com>
	<43624B30.20600@nortel.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BA118E37-D34A-49A2-83C5-6DB665D491BD@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 28 Oct 2005 13:41:11 -0500
To: Christopher Friesen <cfriesen@nortel.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Patches for 2.6.15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 28, 2005, at 11:00 AM, Christopher Friesen wrote:

> Paul Mackerras wrote:
>
>
>> If possible, I'd like to get to the point where we can remove
>> arch/ppc64 entirely by the end of the 2-week merge window for 2.6.15.
>>
>
> I haven't been following this seriously, so forgive me if this has  
> already been asked.
>
> Under the unified architecture, what is the machine type in the  
> "uname" outout?

When building the merge tree for a 32-bit cpu uname spits out:

Linux fred 2.6.14-rc5-g278144ed #9 Thu Oct 27 09:20:01 CDT 2005 ppc  
unknown


- kumar
