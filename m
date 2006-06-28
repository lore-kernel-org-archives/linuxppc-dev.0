Return-Path: <apw@shadowen.org>
Message-ID: <44A29AF5.4010501@shadowen.org>
Date: Wed, 28 Jun 2006 16:06:29 +0100
From: Andy Whitcroft <apw@shadowen.org>
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@google.com>
Subject: Re: 2.6.17-mm2
References: <449D5D36.3040102@google.com>	<449FF3A2.8010907@mbligh.org>	<44A150C9.7020809@mbligh.org>	<20060628034215.c3008299.akpm@osdl.org>
	<20060628034748.018eecac.akpm@osdl.org>
	<44A29582.7050403@google.com>
In-Reply-To: <44A29582.7050403@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Morton <akpm@osdl.org>, jeremy@goop.org, drfickle@us.ibm.com,
	linux-kernel@vger.kernel.org, mbligh@mbligh.org, linuxppc64-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Martin J. Bligh wrote:
> Andrew Morton wrote:
> 
>> On Wed, 28 Jun 2006 03:42:15 -0700
>> Andrew Morton <akpm@osdl.org> wrote:
>>
>>
>>> his is caused by the vsprintf() changes.  Right now, if you do
>>>
>>>     snprintf(buf, 4, "1111111111111");
>>>
>>> the memory at `buf' gets [31 31 31 31 00], which is not good.
>>>
>>> This'll plug it, but I didn't check very hard whether it still has any
>>> off-by-ones, or if breaks the intent of Jeremy's patch.  I think it's
>>> OK..
> 
> 
> Aha, you're a genius! How the hell did you figure that one out?
> 
> Andy / Steve ... any chance one of you could kick this through the
> harness? Against -git10 or so, I'd think
> 
> Thanks,


Suitibly kicked ... against 2.6.17-git10.

-apw
