Return-Path: <jonsmirl@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20090604133152.19022.27114.sendpatchset@subratamodak.linux.ibm.com>
References: <20090604133152.19022.27114.sendpatchset@subratamodak.linux.ibm.com>
Date: Thu, 4 Jun 2009 10:07:06 -0400
Message-ID: <9e4733910906040707o63f81dcdm571b9348ee081b30@mail.gmail.com>
Subject: Re: [BUILD FAILURE 02/04] Next June 04:PPC64 randconfig
	[drivers/usb/host/ohci-hcd.o]
From: Jon Smirl <jonsmirl@gmail.com>
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	Sachin P Sant <sachinp@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-usb@vger.kernel.org,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	David Brownell <david-b@pacbell.net>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Linux-Next <linux-next@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 4, 2009 at 9:31 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> CC =A0 =A0 =A0drivers/usb/host/ohci-hcd.o
> In file included from drivers/usb/host/ohci-hcd.c:1060:
> drivers/usb/host/ohci-ppc-of.c:242:2: error: #error "No endianess selecte=
d for ppc-of-ohci"
> make[3]: *** [drivers/usb/host/ohci-hcd.o] Error 1
> make[2]: *** [drivers/usb/host] Error 2
> make[1]: *** [drivers/usb] Error 2
> make: *** [drivers] Error 2
>
> I reported this earlier, and there were some discussions:
> http://groups.google.co.kr/group/linux.kernel/browse_thread/thread/edff9d=
5572d3d225

Proposed patch by Arnd should fix this. It has not been merged.
http://lkml.org/lkml/2009/4/22/49

--=20
Jon Smirl
jonsmirl@gmail.com
