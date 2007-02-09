Return-Path: <olaf@aepfle.de>
Date: Fri, 9 Feb 2007 19:51:07 +0100
From: Olaf Hering <olaf@aepfle.de>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: Okay to change default zImage link/load address?
Message-ID: <20070209185107.GA12703@aepfle.de>
References: <20070209184345.GA28127@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070209184345.GA28127@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 09, Mark A. Greer wrote:

> Does anyone know of a problem downloading to 8MB instead of 4MB in
> arch/powerpc?  If not, would you object if it changed to 8MB?

IBM chrp 32 and 64bit has a free and usable memory range from 64k to
12M.
Changing the link address from 4 to 8 MB will reduce the max zImage size
to 3MB on these systems.
