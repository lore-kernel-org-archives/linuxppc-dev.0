Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18475.47278.446992.728481@cargo.ozlabs.ibm.com>
Date: Thu, 15 May 2008 14:14:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@linux-foundation.org
Subject: Re: [patch 3/4] macintosh: replace deprecated __initcall with
	device_initcall
In-Reply-To: <200805142312.m4ENCsdu026262@imap1.linux-foundation.org>
References: <200805142312.m4ENCsdu026262@imap1.linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, rpjday@crashcourse.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

akpm@linux-foundation.org writes:

> -__initcall(adb_init);
> +device_initcall(adb_init);

There's no particular reason why this needs to go in 2.6.26, is there?
It looks to me like something that I should queue up for 2.6.27.

Paul.
