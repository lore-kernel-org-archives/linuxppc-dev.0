Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <20050823173142.4f620d75.sfr@canb.auug.org.au>
References: <20050822141235.GA7110@austin.ibm.com>
	<0F51EC83-8969-4083-B0D7-9343D075B635@freescale.com>
	<1124775707.5159.92.camel@gaston>
	<20050823173142.4f620d75.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E470B224-F0FB-48D7-9A04-E42247B11554@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 23 Aug 2005 12:05:36 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: olof@lixom.net, linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] Move all the very similar files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 23, 2005, at 2:31 AM, Stephen Rothwell wrote:

> On Tue, 23 Aug 2005 15:41:47 +1000 Benjamin Herrenschmidt  
> <benh@kernel.crashing.org> wrote:
>
>>
>> Most of the ones that are in include/asm* are there because drivers
>> outside of arch/* use them.
>>
>
> Indeed.  Here is the result of grepping for all of the .h files in  
> patch 3 (minus the
> obvious noncontentious ones like errno.h ...):

This seems reasonable then to have them in include/asm-powerpc.  I  
feel that there are a few files in include/asm-ppc that were only  
used by code in arch/ppc/platforms but I'm probably just crazy.

- kumar
