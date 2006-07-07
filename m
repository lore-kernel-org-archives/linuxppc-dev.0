Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17582.14607.647659.803383@cargo.ozlabs.ibm.com>
Date: Fri, 7 Jul 2006 20:35:59 +1000
From: Paul Mackerras <paulus@samba.org>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [1/5][POWERPC] boot: prepare for zImage.kexec
In-Reply-To: <200607012346.k61NkWXL006760@sullivan.realtime.net>
References: <kexec-zImage-try2@bga.com>
	<200607012346.k61NkWXL006760@sullivan.realtime.net>
Cc: linuxppc-dev@ozlabs.org, Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller writes:

> This patch moves the initializations of prom variables to boot/prom.c
> to allow it to be replaced for kexec.   Kexec does not care about
> the stdout handle, but will care about the location of the device
> tree and will search for RTAS.

Unfortunately it doesn't apply now because of other changes to
boot.h.  Please respin the series against the powerpc.git tree.

Thanks,
Paul.
