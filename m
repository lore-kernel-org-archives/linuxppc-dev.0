Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18600.49085.258988.426963@cargo.ozlabs.ibm.com>
Date: Mon, 18 Aug 2008 10:18:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] powerpc: make CMO paging space pool ID and page size
	available
In-Reply-To: <20080815190730.GB20629@austin.ibm.com>
References: <20080815190230.GA20629@austin.ibm.com>
	<20080815190730.GB20629@austin.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Robert Jennings writes:

> During platform setup, save off the primary/secondary paging space pool IDs
> and the page size.  Added accessors in hvcall.h for these variables.
> 
> Submitted-by: Robert Jennings <rcj@linux.vnet.ibm.com>

What's this "Submitted-by"?  Did you mean to type "Signed-off-by"?

Paul.
