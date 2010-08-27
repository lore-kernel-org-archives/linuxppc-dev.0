Return-Path: <tony@bakeyournoodle.com>
Date: Fri, 27 Aug 2010 10:46:26 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: divya <dipraksh@linux.vnet.ibm.com>
Subject: Re: Power machines fail to boot after build being successful
Message-ID: <20100827004626.GU24591@ozlabs.org>
References: <4C764F52.5050707@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4C764F52.5050707@linux.vnet.ibm.com>
Cc: linux-next@vger.kernel.org, LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 26, 2010 at 04:56:10PM +0530, divya wrote:
> Hi,
> 
> After successfully building the kernel version 2.6.36-rc2-git4(commitid
> d4348c678977c) with the config file attached(used make oldconfig),
> P5 and P6 power machines fails to reboot with the following logs

<snip>

> Preparing to boot Linux version 2.6.36-rc2-autotest-next-20100826 (root@llm62) (gcc version 4.3.2 [gcc-4_3-branch revision 141291] (SUSE Linux) ) #1 SMP Thu Aug 26 10:55:01 IST 2010

You say you're booting -git4 but you're running kernel is Linux next from Aug.
26th  Can you confirm you see this boot failure with Linus's tree NOT linux
next?

Adding linux-ppc and linux-next lists.

Yours Tony
