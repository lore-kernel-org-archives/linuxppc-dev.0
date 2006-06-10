Return-Path: <mbligh@mbligh.org>
Message-ID: <448ADDA1.7090608@mbligh.org>
Date: Sat, 10 Jun 2006 07:56:33 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc6-mm2
References: <20060609214024.2f7dd72c.akpm@osdl.org>
In-Reply-To: <20060609214024.2f7dd72c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/
> 
> 
> - Added the s390 git tree to the -mm lineup, as git-s390.patch (Martin
>   Schwidefsky)
> 
> - ppc64 (on mac g5) fails to boot for me, due to changes in the powerpc tree.

Doesn't even build here.

arch/powerpc/platforms/built-in.o(.text+0x1053c): In function 
`.scanlog_read':
: undefined reference to `.rtas_extended_busy_delay_time'

Config:
http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/p570
or
http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/power4


The non-PPC64 machines seem to have done a clean run for the first time
in a while ... yay!

M.
