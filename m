Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18346.19527.92063.259932@cargo.ozlabs.ibm.com>
Date: Thu, 7 Feb 2008 11:09:43 +1100
From: Paul Mackerras <paulus@samba.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC][PATCH] remove section mappinng
In-Reply-To: <1201558765.29357.1.camel@dyn9047017100.beaverton.ibm.com>
References: <1201277105.26929.36.camel@dyn9047017100.beaverton.ibm.com>
	<18330.35819.738293.742989@cargo.ozlabs.ibm.com>
	<1201558765.29357.1.camel@dyn9047017100.beaverton.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>, linuxppc-dev@ozlabs.org, anton@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Badari Pulavarty writes:

> Thank you for your input and suggestions. Does this look reasonable
> to you ?
> 
> Thanks,
> Badari
> 
> For memory remove, we need to clean up htab mappings for the
> section of the memory we are removing.
> 
> This patch implements support for removing htab bolted mappings
> for ppc64 lpar. Other sub-archs, may need to implement similar
> functionality for the hotplug memory remove to work. 

Looks OK to me.

Paul.
