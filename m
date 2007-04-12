Return-Path: <olaf@aepfle.de>
Date: Thu, 12 Apr 2007 06:23:37 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 3/3] cell: prevent alignment interrupt on local store
Message-ID: <20070412042337.GA21832@aepfle.de>
References: <20070410111508.GA2969@localhost.localdomain>
	<1176240168.8061.51.camel@localhost.localdomain>
	<20070411025605.GB2197@localhost.localdomain>
	<1176262253.8061.60.camel@localhost.localdomain>
	<ffb78cbadfea8d104c8e5d495e9651ca@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <ffb78cbadfea8d104c8e5d495e9651ca@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Akinobu Mita <mita@fixstars.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 11, Segher Boessenkool wrote:

> This isn't just a kernel issue either; the same holds
> for all of userspace.  It seems to me the only way to
> get good performance on both Cell and all other platforms
> is to have a separate binary distribution for Cell.

How much will this impact performance on a 970, 74xx or POWER6 if
everything gets compiled with '--mcpu=$cell', compared to what is used
today? One gets at least altivec that way.
