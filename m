Return-Path: <mbligh@google.com>
Message-ID: <44564BEC.1040803@google.com>
Date: Mon, 01 May 2006 10:57:00 -0700
From: Martin Bligh <mbligh@google.com>
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: 2.6.17-rc2-mm1
References: <4450F5AD.9030200@google.com>	
	<20060428012022.7b73c77b.akpm@osdl.org>
	<44561A1E.7000103@google.com>	
	<20060501100731.051f4eff.akpm@osdl.org>	
	<1146503960.317.1.camel@dyn9047017100.beaverton.ibm.com>	
	<445644B7.7060807@google.com>
	<1146506105.317.4.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1146506105.317.4.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org, ak@suse.de,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Badari Pulavarty wrote:
> On Mon, 2006-05-01 at 10:26 -0700, Martin Bligh wrote:
> 
>>>I ran mtest01 multiple times with various options on my 4-way AMD64 box.
>>>So far couldn't reproduce the problem (2.6.17-rc3-mm1).
>>>
>>>Are there any special config or test options you are testing with ?
>>
>>Config is here:
>>
>>http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/amd64
>>
>>It's just doing "runalltests", I think.
> 
> 
> FWIW, I tried your config file on my 4-way AMD64 (melody) box 
> and ran latest "mtest01" fine.
> 
> I am now trying runalltests. I guess, its time to bi-sect :(

There was a panic on PPC64 during LTP too, but it seems to have gone
away with rc3-mm1. Not sure if it was really fixed, or just intermittent.

http://test.kernel.org/abat/29675/debug/console.log

M.
