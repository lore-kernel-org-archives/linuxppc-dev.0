Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 02521DDDF4
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 12:52:30 +1100 (EST)
Date: Mon, 5 Nov 2007 20:01:39 -0600
From: Olof Johansson <olof@lixom.net>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] pasemi: Broaden specific references to 1682M
Message-ID: <20071106020139.GA2297@lixom.net>
References: <20071105032802.GA16613@lixom.net>
	<cd9a9e67893406e486d2ffc7599e28b7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cd9a9e67893406e486d2ffc7599e28b7@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 06, 2007 at 02:42:08AM +0100, Segher Boessenkool wrote:
> Hi Olof,
>
> Nice cleanup!  One minor thing...
>
>>  static struct of_device_id pasemi_bus_ids[] = {
>> +	/* Unfortunately needed for legacy firmwares */
>>  	{ .type = "localbus", },
>>  	{ .type = "sdc", },
>> +	{ .compatible = "pasemi,localbus", },
>> +	{ .compatible = "pasemi,sdc", },
>
> The new comment is for the device_type entries only, right?  You
> might want to make that more clear.

Good point. I'll clarify it with a new comment above the compatible
entries. I won't repost the patch since the change is minor, but include
it for the upstream push.


Thanks,

-Olof
