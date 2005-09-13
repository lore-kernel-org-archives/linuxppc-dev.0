Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <20050913203555.GB18639@dmt.cnet>
References: <20050913203555.GB18639@dmt.cnet>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <28EAC1FF-341D-45C3-BA9E-221AE04F6DC1@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 13 Sep 2005 16:43:31 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linuxppc-dev@ozlabs.org, cort@fsmlabs.com,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: __switch_to test-and-branch ALTIVEC specific?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 13, 2005, at 3:35 PM, Marcelo Tosatti wrote:

> On Tue, Sep 13, 2005 at 02:05:57PM -0500, Kumar Gala wrote:
>
>> This probably has to due with what happens on a G4 system with a
>> kernel not build with Altivec.. However, I dont remember exactly what
>>
>
>
>> behavior is desired.
>>
>
> What would be the appropriate set of definitions to use, then ?
>
> #if defined (CONFIG_ALTIVEC || CONFIG_6xx) ?

That's probably better.  Hopefully Ben will have some reason if what  
you suggest is not sufficient.

- k
