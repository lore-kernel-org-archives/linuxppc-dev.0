Return-Path: <jacmet@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.185])
	by ozlabs.org (Postfix) with ESMTP id E0064DDFA5
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 05:04:17 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so4748435fkz
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 12:04:16 -0700 (PDT)
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 02/12] Virtex: Add Kconfig macros for Xilinx Virtex
	board support
References: <20071002021334.9579.68179.stgit@trillian.cg.shawcable.net>
	<20071002021518.9579.24264.stgit@trillian.cg.shawcable.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 02 Oct 2007 21:04:09 +0200
In-Reply-To: <20071002021518.9579.24264.stgit@trillian.cg.shawcable.net>
	(Grant Likely's message of "Mon\, 01 Oct 2007 20\:15\:18 -0600")
Message-ID: <87ejgdz6c6.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 Grant> From: Grant Likely <grant.likely@secretlab.ca>
 Grant> Add the needed kconfig macros to enable Xilinx Virtex board support

..

 Grant> +config XILINX_VIRTEX_II_PRO
 Grant> +	bool
 Grant> +	select XILINX_VIRTEX
 Grant>  	select IBM405_ERR77
 Grant>  	select IBM405_ERR51
 
 Grant> +config XILINX_VIRTEX_4_FX
 Grant> +	bool
 Grant> +	select XILINX_VIRTEX
 Grant> +

This seems different than under arch/ppc - The errattas were also
enabled for the V4FX - What is correct?

-- 
Bye, Peter Korsgaard
