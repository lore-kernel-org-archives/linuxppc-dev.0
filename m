Return-Path: <pbadari@us.ibm.com>
Message-ID: <445699BE.40709@us.ibm.com>
Date: Mon, 01 May 2006 16:29:02 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.17-rc2-mm1
References: <4450F5AD.9030200@google.com>	
	<20060428012022.7b73c77b.akpm@osdl.org>
	<44561A1E.7000103@google.com>	
	<20060501100731.051f4eff.akpm@osdl.org>	
	<1146503960.317.1.camel@dyn9047017100.beaverton.ibm.com>	
	<445644B7.7060807@google.com>
	<1146506105.317.4.camel@dyn9047017100.beaverton.ibm.com>
	<44564BEC.1040803@google.com> <44565443.3020000@shadowen.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
	lkml <linux-kernel@vger.kernel.org>,
	Martin Bligh <mbligh@google.com>, ak@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Andy Whitcroft wrote:

>Martin Bligh wrote:
>
>>Badari Pulavarty wrote:
>>
>>>On Mon, 2006-05-01 at 10:26 -0700, Martin Bligh wrote:
>>>
>>>>>I ran mtest01 multiple times with various options on my 4-way AMD64
>>>>>box.
>>>>>So far couldn't reproduce the problem (2.6.17-rc3-mm1).
>>>>>
>>>>>Are there any special config or test options you are testing with ?
>>>>>
>>>>
>>>>Config is here:
>>>>
>>>>http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/amd64
>>>>
>>>>It's just doing "runalltests", I think.
>>>>
>>>
>>>
>>>FWIW, I tried your config file on my 4-way AMD64 (melody) box and ran
>>>latest "mtest01" fine.
>>>
>>>I am now trying runalltests. I guess, its time to bi-sect :(
>>>
>>
>>There was a panic on PPC64 during LTP too, but it seems to have gone
>>away with rc3-mm1. Not sure if it was really fixed, or just intermittent.
>>
>>http://test.kernel.org/abat/29675/debug/console.log
>>
>
>I think its more intermittant than gone.  I've got another machine which
>runs the same tests, and she threw a very similar failure on 2.6.18-rc3-mm1.
>
I ran whole LTP with 2.6.17-rc3-mm1 on my (2-way P710) Power box and
didn't see any crashes. I also ran LTP on AMD64 box without any crashes.

Thanks,
Badari
