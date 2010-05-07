Return-Path: <maciej.rutecki@gmail.com>
From: Maciej Rutecki <maciej.rutecki@gmail.com>
To: subrata@linux.vnet.ibm.com
Subject: Re: Suspicious rcu_dereference_check() usage detected during
	2.6.34-rc6 boot on PPC64/p5 processor
Date: Fri, 7 May 2010 16:17:49 +0200
References: <1273130279.4898.5.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1273130279.4898.5.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201005071617.49253.maciej.rutecki@gmail.com>
Cc: Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Reply-To: maciej.rutecki@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On czwartek, 6 maja 2010 o 09:17:59 Subrata Modak wrote:
> Hi,
> 
> The following messages were logged into /var/log/messages when i booted
> 2.6.34-rc6 kernel (built with attached CONFIG file contents ) on my p5 box:
> 

I created a Bugzilla entry at 
https://bugzilla.kernel.org/show_bug.cgi?id=15936
for your bug report, please add your address to the CC list in there, thanks!
-- 
Maciej Rutecki
http://www.maciek.unixy.pl
