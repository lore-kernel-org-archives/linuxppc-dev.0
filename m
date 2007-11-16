Return-Path: <dale@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 16 Nov 2007 11:48:26 -0700
To: marco.stornelli@coritel.it, Linuxppc-embedded@ozlabs.org
Subject: Re: Kexec on powerpc
Message-ID: <20071116184826.GA18952@xyzzy.farnsworth.org>
References: <10602.129.192.97.5.1195132467.squirrel@nausicaa2.coritel.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10602.129.192.97.5.1195132467.squirrel@nausicaa2.coritel.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Nov 15, 2007 at 01:14:27PM +0000, marco.stornelli@coritel.it wrote:
> I'm using the latest kernel and I need the kexec support for 85xx
> processor. When I use the menuconfig with ARCH=ppc and the 85xx and
> e500 support, I have the kexec support, but when I use ARCH=powerpc I
> haven't it, but I'm selecting the same processor!! Is it a bug in
> kconfig? Somebody can explain to me why?

I don't think kexec works for ppc-32 arch/powerpc at the present.
We have been working on kexec/kdump support for 32-bit arch/powerpc.
It requires changes both to the kernel and to the kexec-tools package.

I plan to post a first round of patches to linuxppc-dev early next week.

-Dale Farnsworth
