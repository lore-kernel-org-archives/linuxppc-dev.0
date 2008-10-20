Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0C8A8DDDDB
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 07:47:39 +1100 (EST)
Date: Tue, 21 Oct 2008 00:47:37 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for-2.6.28' branch
Message-ID: <20081020204737.GA13189@oksana.dev.rtsoft.ru>
References: <Pine.LNX.4.64.0810201304160.17086@blarg.am.freescale.net>
	<20081020191731.GA26789@oksana.dev.rtsoft.ru>
	<76F4ACB5-204A-46F7-BE4F-069CA58114B3@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <76F4ACB5-204A-46F7-BE4F-069CA58114B3@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 20, 2008 at 02:32:21PM -0500, Kumar Gala wrote:
>
> On Oct 20, 2008, at 2:17 PM, Anton Vorontsov wrote:
>
>> Hi Kumar,
>>
>> On Mon, Oct 20, 2008 at 01:04:36PM -0500, Kumar Gala wrote:
>>> Please pull from 'for-2.6.28' branch of
>>>
>>> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git  
>>> for-2.6.28
>>
>> Could you tell the status of this patch?
>>
>> [1/4] powerpc/QE: implement QE Pin Multiplexing API
>> http://patchwork.ozlabs.org/patch/4897/
>>
>> I reposted it several times (w/o changes), received no comments.
>> If it's ok, could you merge it for 2.6.28?
>
> Sorry, I was thinking this patch required an OF interface change getting 
> accepted... is that true?

Benjamin merged the OF patch, it's in the Linus' tree already.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
