Return-Path: <hartleys@visionengravers.com>
Received: from exprod6og104.obsmtp.com (exprod6og104.obsmtp.com [64.18.1.187])
	by ozlabs.org (Postfix) with SMTP id 68F98B6EF4
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jan 2010 01:33:59 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH] arch/powerpc/boot/devtree.c: use %pM to show MAC address
Date: Thu, 31 Dec 2009 09:33:55 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200F6BB@mi8nycmail19.Mi8.com>
In-Reply-To: <20091231044926.GC18358@brick.ozlabs.ibm.com>
References: <BD79186B4FD85F4B8E60E381CAEE19090200F65E@mi8nycmail19.Mi8.com>
	<20091231044926.GC18358@brick.ozlabs.ibm.com>
From: "H Hartley Sweeten" <hartleys@visionengravers.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, December 30, 2009 9:49 PM, Paul Mackerras wrote:
> On Wed, Dec 30, 2009 at 02:30:39PM -0500, H Hartley Sweeten wrote:
>
>> Use the %pM kernel extension to display the MAC address.
>>=20
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>>=20
>> ---
>
> Nak - this isn't the kernel, this is a separate program, namely the
> bootwrapper that decompresses the kernel image, and it has its own
> printf (not printk) implementation in arch/powerpc/boot/stdio.c, which
> doesn't understand the %pX extensions (and I don't see any good reason
> to make it do so).

OK.  Sorry for the noise.

Regards,
Hartley
