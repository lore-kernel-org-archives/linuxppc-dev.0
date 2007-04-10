Return-Path: <benh@kernel.crashing.org>
Subject: Re: [patch 3/3] cell: prevent alignment interrupt on local store
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Akinobu Mita <mita@fixstars.com>
In-Reply-To: <20070410111508.GA2969@localhost.localdomain>
References: <20070410111508.GA2969@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 11 Apr 2007 07:22:48 +1000
Message-Id: <1176240168.8061.51.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-10 at 20:15 +0900, Akinobu Mita wrote:
> An Alignment interrupt occurs when the instruction is lmw, stmw, lswi, lswx,
> stswi, or stswx, and the operand is in local store.
> 
> GCC generated such instructions to handle memcpy() instead of kernel
> defined memcpy() without -mno-string option.
> 
> Signed-off-by: Akinobu Mita <mita@fixstars.com>

I would personally prefer building the entire kernel with -mno-string
when cell support is enabled...

Ben.
