Return-Path: <olof@austin.ibm.com>
Date: Fri, 4 Feb 2005 12:35:14 -0600
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20050204183514.GB17586@austin.ibm.com>
References: <20050204072254.GA17565@austin.ibm.com>
	<200502041336.59892.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200502041336.59892.arnd@arndb.de>
From: olof@austin.ibm.com (Olof Johansson)
Cc: akpm@osdl.org, trini@kernel.crashing.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, hpa@zytor.com,
	linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 04, 2005 at 01:36:55PM +0100, Arnd Bergmann wrote:
> I have a somewhat similar patch that does the same to the
> systemcfg->platform checks. I'm not sure if we should use the same inline
> function for both checks, but I do think that they should be used in a
> similar way, e.g. CPU_HAS_FEATURE(x) and PLATFORM_HAS_FEATURE(x).

Yep. Firmware features are also on the list. I figured I'd do CPU features
first though since they are the ones that started bugging me.

> The same stuff is obviously possible for cur_cpu_spec->cpu_features as well.
> Do you think that it will help there?

Nice. It won't be quite as easy to do compile-time for cpu features.
pSeries will need all cpus enabled since we have them all on various
machines, etc. I guess Powermac/Maple could benefit from it. In the
end it depends on how hairy the implementation would get vs performance
improvement.


-Olof
