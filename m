Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17305.65335.253519.555549@cargo.ozlabs.ibm.com>
Date: Sat, 10 Dec 2005 09:03:35 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20051209180728.GA1144@suse.de>
References: <20051209180728.GA1144@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] make ARCH=powerpc the default
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

> -				  -e s/ppc64/powerpc/ )
> +				  -e s/ppc\\\(64\\\)\\\?/powerpc/ )

Hmmm, I was going to just do s/ppc.*/powerpc/.

Paul.
