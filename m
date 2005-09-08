Return-Path: <dan@embeddededge.com>
In-Reply-To: <D8DEC759-EAB9-457F-AF7B-A10D6593B27A@freescale.com>
References: <200509090008.39692.pantelis.antoniou@gmail.com>
	<D8DEC759-EAB9-457F-AF7B-A10D6593B27A@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f2ea45e1b2a9689c450811a61ed46183@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 8 Sep 2005 17:48:58 -0400
To: Kumar Gala <kumar.gala@freescale.com>
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


On Sep 8, 2005, at 5:20 PM, Kumar Gala wrote:

>>>          if (!cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
>>>                  __flush_icache_range(start, stop);
>>> }

If we #define CPU_FTR_xxx as a 0 or all 1's for processors that have
or don't have these features, will the compiler be smart enough to
recognize an always true or false condition and remove the
test (or code as appropriate)?

Thanks.

	-- Dan
