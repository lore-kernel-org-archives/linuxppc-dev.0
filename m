Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 13689679FB
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 02:34:59 +1000 (EST)
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673062C0A97@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD4673062C0A97@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D4A31A51-C9AE-48F3-A747-46AC9767B598@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Thu, 18 May 2006 11:35:11 -0500
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 18, 2006, at 5:21 AM, Zang Roy-r61911 wrote:

>
>> On Thu, 2006-05-18 at 15:12 +0800, Zang Roy-r61911 wrote:
>>>> I'm not repeating Kumar's comments about that CONFIG_7xxx
>>>> thing and that
>>>> 7xxx/ directory, it should all go.
>>>>
>>>
>>> Should I move my code to embedded6xx?
>>
>> Probably for now yes.
>
> I can migrate my code to embedded6xx technically. In fact,
> I can move it into anywhere in the arch/powerpc/platforms.
> While for mpc7448hpc2(taiga) board, it is not a embedded
> application board. It is a high performance server! It seems
> odd to put code there :). What's your opinion?

We should rename the files so they are 7448 specific.  I dont see any  
reason if FSL comes up with a 7449 that it wouldn't run on the same  
board.

- k
