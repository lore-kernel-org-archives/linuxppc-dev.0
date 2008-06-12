Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: michael@ellerman.id.au
Subject: Re: [Cbe-oss-dev] [PATCH] powerpc/cell: disable ptcal in case of
	kdump reboot
Date: Thu, 12 Jun 2008 09:39:21 +0200
References: <200806111828.59043.arnd@arndb.de>
	<1213202956.28589.4.camel@localhost>
In-Reply-To: <1213202956.28589.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200806120939.23836.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 11 June 2008, Michael Ellerman wrote:
> On Wed, 2008-06-11 at 18:28 +0200, Arnd Bergmann wrote:
> > We used to do this correctly in case of a user triggered
> > kexec, but not for kdump.
> 
> Used to?

Sorry, wrong wording. I meant without this patch, it's correct
for kexec.
 
> > This patch disables ptcal from the cell specific
> > machine_crash_shutdown() callback. 
> 
> I'd rather you used the crash_shutdown_register() infrastructure Mikey
> added for EHEA - it's designed for just this sort of thing.

Thanks for pointing this out, I wasn't aware of that call.
New patch coming up.

	Arnd <><
