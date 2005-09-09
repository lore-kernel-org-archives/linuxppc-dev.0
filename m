Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <1126216432.29803.31.camel@gaston>
References: <1126216432.29803.31.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A21BE716-E470-415A-A6AD-E83292BEE6C3@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 8 Sep 2005 20:30:58 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, linas <linas@austin.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: r13 is non-volatile?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 8, 2005, at 4:53 PM, Benjamin Herrenschmidt wrote:

>
>
>> There's a different value in R13 depending on which cpu you're on,
>> so one mustn't save R13 on one CPU and attempt to restore it on
>> another.
>>
>> Maybe, for ppc32, you can pretend that r13 "is like a paca"? So
>> that instead of saving/restoring r13 like this, you could set it up
>> at the same time/instead of setting up the paca r13?
>>
>
> ppc32 uses r2 for that, it contains "current".
>
> I don't think we need to bother merging those low level CPU specific
> things. We need to have a cpu32 and a cpu64 subdirs in there for  
> things
> like these, memory management, etc... imho.

My intent is to see if we can make a change so that there isn't an  
ifdef.

- kumar
