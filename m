Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0602072206290.2458@g5.osdl.org>
References: <1139377372.8187.16.camel@localhost.localdomain>
	<Pine.LNX.4.64.0602072206290.2458@g5.osdl.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <87E547D2-A8FC-4A89-89A4-60313C9647B0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Thermal control for dual core G5s
Date: Wed, 8 Feb 2006 08:52:33 -0600
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 8, 2006, at 12:07 AM, Linus Torvalds wrote:

>
>
> On Wed, 8 Feb 2006, Benjamin Herrenschmidt wrote:
>>
>> This patch adds a windfarm module, windfarm_pm112, for the dual  
>> core G5s
>> (both 2 and 4 core models), keeping the machine from getting into
>> vacuum-cleaner mode ;)
>
> This seems to introduce a new warning..
>
>   arch/powerpc/platforms/83xx/Kconfig:10:
> 	warning: 'select' used by config symbol 'MPC834x_SYS' refer to  
> undefined symbol 'DEFAULT_UIMAGE'

That's my fault.  Paul did push a simple build system update.  I'll  
ask him to do so.

http://ozlabs.org/pipermail/linuxppc-dev/2006-January/020980.html

- kumar
