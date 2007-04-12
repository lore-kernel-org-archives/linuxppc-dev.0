Return-Path: <olaf@aepfle.de>
Date: Thu, 12 Apr 2007 08:33:21 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 3/3] cell: prevent alignment interrupt on local store
Message-ID: <20070412063321.GA23118@aepfle.de>
References: <20070410111508.GA2969@localhost.localdomain>
	<1176240168.8061.51.camel@localhost.localdomain>
	<20070411025605.GB2197@localhost.localdomain>
	<1176262253.8061.60.camel@localhost.localdomain>
	<ffb78cbadfea8d104c8e5d495e9651ca@kernel.crashing.org>
	<20070412042337.GA21832@aepfle.de>
	<1176355566.8061.121.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1176355566.8061.121.camel@localhost.localdomain>
Cc: Arnd Bergmann <arnd@arndb.de>, Akinobu Mita <mita@fixstars.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 12, Benjamin Herrenschmidt wrote:

> Gets altivec and stops working on POWER5 ? no deal :-)

If there is a significant performance gain (not only 9%) and if
-mcpu=$cell does not generate instructions that wont work on other
altivec capable cpus and if rpm gets a target ppcaltivec.rpm (or
similar), as separate binary tree can be done.
