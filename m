Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [64.234.241.98])
	by ozlabs.org (Postfix) with ESMTP id 725CEB710B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Feb 2011 11:25:50 +1100 (EST)
Message-ID: <4D5B1985.90101@mlbassoc.com>
Date: Tue, 15 Feb 2011 17:25:41 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: FSL USB in 2.6.37
References: <4D5ABC25.80104@mlbassoc.com> <20110215191856.67f8f0c4@wker>
In-Reply-To: <20110215191856.67f8f0c4@wker>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/15/2011 11:18 AM, Anatolij Gustschin wrote:
> On Tue, 15 Feb 2011 10:47:17 -0700
> Gary Thomas<gary@mlbassoc.com>  wrote:
>
>> I'm trying to get my platform support working in mainline
>> 2.6.37.  I have a MPC8379 which is working well in 2.6.32.
>>
>> When I just move my platform to the new kernel, everything
>> works except for USB host mode.  Nothing special about my
>> platform - it's pretty much like the FSL eval boards (as
>> far as this part is concerned).  I can see it start up,
>> claim to power up the internal hub, but I never see the
>> state change interrupt from the hub.
>>
>> Are there any known gotchas here?  Any ideas?
>
> Does this patch [1] help?
>
> [1] http://patchwork.ozlabs.org/patch/78260/

Indeed, it fixes my problem :-)

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
