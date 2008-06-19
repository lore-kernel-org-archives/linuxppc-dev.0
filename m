Return-Path: <jdl@freescale.com>
Message-ID: <485AA9BF.6090403@freescale.com>
Date: Thu, 19 Jun 2008 13:47:27 -0500
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH] fs_enet: restore promiscuous and multicast settings in
	restart()
References: <200806181707.17739.laurentp@cse-semaphore.com>	<8496f91a0806181145w62d57a7fua767c8036f2261aa@mail.gmail.com>
	<20080619222042.2910e284@vitb.ru.mvista.com>
In-Reply-To: <20080619222042.2910e284@vitb.ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, matvejchikov@gmail.com,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> On Wed, 18 Jun 2008 22:45:57 +0400
> "Matvejchikov Ilya" <matvejchikov@gmail.com> wrote:
> 
>> I'm glad that you have corrected it. Half a year ago I pointed out
>> that there was such a mistake:
>> http://patchwork.ozlabs.org/linuxppc/patch?id=10700
>>
> You've used -embedded ML, and patch wasn't noticed... 

*sigh*

We should merge the -embedded list into -dev
and retire the -embedded list finally.

jdl
