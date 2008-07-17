Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <200807170058.53599.arnd@arndb.de>
References: <1216186406-27993-1-git-send-email-fkan@amcc.com>
	<200807161646.02306.arnd@arndb.de>
	<20080716154646.GH24045@secretlab.ca>
	<200807170058.53599.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <259d93b7d6b03cada58fecaf875fea31@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Add AMCC Arches 460GT eval board support to platforms/44x
Date: Thu, 17 Jul 2008 05:24:29 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Victor Gallardo <vgallard@amcc.com>, fkan@amcc.com,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Shouldn't it be enough to have a common compatible value in each
>>> of these boards, e.g. "amcc,generic-ppc44x" and then just ignore the
>>> specific type unless you need to do something special?
>>
>> This is bad for the same reason that "amcc,44x-<blah>" compatible=20
>> values
>> are bad in device nodes. =A0The definition of '*-44x-*' changes over=20=

>> time as
>> new parts are added. =A0Compatible values should always reflect an =
exact
>> part number.
>
> I agree in general, but I also think that all 44x boards should be
> regarded as the same machine time, in the same way that all powermacs
> are detected as compatible with "Power Macintosh" or "MacRISC", or
> how all sorts of serial ports claim compatibility with i8250.

And they can do that because a binding for those "compatible" names
exists, that describes exactly what it means for a device to be "i8250"
or "MacRISC" (well, in that last case, maybe such a binding exists, or
maybe it doesn't, but we don't know about it anyway, sigh).


Segher
