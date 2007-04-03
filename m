Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] cbe_cpufreq.c initialisation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070403182037.93221d65.sfr@canb.auug.org.au>
References: <20070403182037.93221d65.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Tue, 03 Apr 2007 18:37:31 +1000
Message-Id: <1175589451.30879.14.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-03 at 18:20 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In cbe_cpufreq_cpu_init, there is this code:
> 
> 	max_freq = (u32*) get_property(cpu, "clock-frequency", NULL);
>         // we need the freq in kHz
>         *max_freq /= 1000;
> 
> does this really need to modify the property value in place?

No, that's obviously a bug...

Ben.
