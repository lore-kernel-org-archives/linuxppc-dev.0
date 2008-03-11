Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18390.9349.330212.214849@cargo.ozlabs.ibm.com>
Date: Tue, 11 Mar 2008 17:19:49 +1100
From: Paul Mackerras <paulus@samba.org>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 6/8] pseries: phyp dump: Invalidate and print dump areas.
In-Reply-To: <47C75292.6000705@austin.ibm.com>
References: <47B90F55.2080606@austin.ibm.com>
	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
	<47C74A66.1060105@austin.ibm.com> <47C75292.6000705@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linasvepstas@gmail.com, mahuja@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Manish Ahuja writes:

> -static void
> -release_memory_range(unsigned long start_pfn, unsigned long nr_pages)
> +static
> +void release_memory_range(unsigned long start_pfn, unsigned long nr_pages)

This change looks rather pointless.  If you have to change it, I'd
prefer:

static void release_memory_range(unsigned long start_pfn,
			unsigned long nr_pages)

Paul.
