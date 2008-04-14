Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 3A9FADED2A
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 03:50:17 +1000 (EST)
Date: Mon, 14 Apr 2008 21:49:45 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/8] A bit of new code and sparse cleanups along the way
Message-ID: <20080414174945.GA22764@polina.dev.rtsoft.ru>
References: <20080311172106.GA4766@localhost.localdomain>
	<4064F5C3-0A62-4331-9116-764347AEC090@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4064F5C3-0A62-4331-9116-764347AEC090@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 14, 2008 at 10:14:05AM -0500, Kumar Gala wrote:
>
> On Mar 11, 2008, at 12:21 PM, Anton Vorontsov wrote:
>> Hi all,
>>
>> Please consider these patches for the 2.6.26.
>
> I've applied most of these patches to my powerpc-next branch.

Thanks!

> The  
> following two patches have NOT been applied:
>
> [POWERPC] sysdev,qe_lib: implement FSL GTM support
> [POWERPC] qe_lib: add support for QE USB
>
> It seemed there was rework required to the sysdev,qe_lib patch.

I can't recall any issues with "[POWERPC] qe_lib: add support for QE USB".

As for FSL GTM.. yes, I'll send updated version soon.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
