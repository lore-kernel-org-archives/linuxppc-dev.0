Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1175276728.3122.161.camel@pmac.infradead.org>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<460D4BC3.8030805@am.sony.com>
	<1175276728.3122.161.camel@pmac.infradead.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3f028c6d87efaadfadee6894656ff220@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
Date: Fri, 30 Mar 2007 20:11:46 +0200
To: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The proper way is to parse out just the command line from the 
>> incompatible
>> DT, and use that with the new DT supplied by the bootwrapper.  I 
>> planed
>> to do that in my bootwrapper, but haven't coded it yet.
>
> There is no bootwrapper here. We boot a plain vmlinux, which needs to
> cope.

Maybe you should use a bootwrapper, instead.

It doesn't make sense to duplicate lots of firmware
and bootloader/bootwrapper functionality in the kernel
just for kexec.  (Or to do that at all, really).


Segher
