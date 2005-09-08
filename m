Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <f2ea45e1b2a9689c450811a61ed46183@embeddededge.com>
References: <f2ea45e1b2a9689c450811a61ed46183@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <39A39EEE-E3B1-4D34-BC6E-854C3EF56C7D@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 8 Sep 2005 17:02:30 -0500
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	pantelis.antoniou@gmail.com, linuxppc-embedded@ozlabs.org
Subject: Re: cpu features testing 32 vs 64 bit
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 8, 2005, at 4:48 PM, Dan Malek wrote:

>
> On Sep 8, 2005, at 5:20 PM, Kumar Gala wrote:
>
>
>>>>          if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
>>>>                  __flush_icache_range(start, stop);
>>>> }
>>>>
>
> If we #define CPU_FTR_xxx as a 0 or all 1's for processors that have
> or don't have these features, will the compiler be smart enough to
> recognize an always true or false condition and remove the
> test (or code as appropriate)?

The compiler is smart enough in this case since cpu_has_feature() is  
an inline function.

- kumar
