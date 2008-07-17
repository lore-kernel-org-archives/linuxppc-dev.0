Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20080716154646.GH24045@secretlab.ca>
References: <1216186406-27993-1-git-send-email-fkan@amcc.com>
	<20080716075025.0bca152c@zod.rchland.ibm.com>
	<20080716141539.GC24045@secretlab.ca>
	<200807161646.02306.arnd@arndb.de>
	<20080716154646.GH24045@secretlab.ca>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <16eddae5007f7d133818af806e22396d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Add AMCC Arches 460GT eval board support to platforms/44x
Date: Thu, 17 Jul 2008 05:19:44 +0200
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Victor Gallardo <vgallard@amcc.com>, fkan@amcc.com,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Shouldn't it be enough to have a common compatible value in each
>> of these boards, e.g. "amcc,generic-ppc44x" and then just ignore the
>> specific type unless you need to do something special?
>
> This is bad for the same reason that "amcc,44x-<blah>" compatible 
> values
> are bad in device nodes.  The definition of '*-44x-*' changes over 
> time as
> new parts are added.  Compatible values should always reflect an exact
> part number.

Erm, no.

"compatible" entries should always contain the real part name to reduce
the chance that separate parties come up with the same "compatible"
name for two different devices.

Other than that, the name really doesn't matter, it's just _some_
string that uniquely identifies a device; and the device bindings will
document what is what.

Of course, if no binding is written, it becomes a lot more important
that names have a sane value ;-)


Segher
