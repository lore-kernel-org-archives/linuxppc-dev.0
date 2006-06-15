Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17553.57932.127038.417630@cargo.ozlabs.ibm.com>
Date: Fri, 16 Jun 2006 08:42:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH]: powerpc: pseries: Print PCI slot location code on failure
In-Reply-To: <20060615221527.GD12389@austin.ibm.com>
References: <20060615221527.GD12389@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas writes:

> Resending an older patch (from 28 April) that seems to have fallen
> through the cracks, its not in mailine, is not in -mm and its not
> controversial (its mostly a printk change). Tested.

I don't like doing printk on things that might be NULL (i.e. the
result of get_property).  Even though printk doesn't crash, it would
be nicer for the user to see "location=unknown" or something rather
than "location=<NULL>".

Paul.
