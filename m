Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17784.46252.935.759285@cargo.ozlabs.ibm.com>
Date: Fri, 8 Dec 2006 11:41:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [patch 0/1] ipmi: add autosensing of ipmi device on powerpc using
	device-tree
In-Reply-To: <20061207172259.64168f8c@localhost>
References: <20061207172259.64168f8c@localhost>
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christian Krafft writes:

> the patch I'll send, adds of_device support to the ipmi_si module.
> Having the correct device-tree entries, the ipmi module can be loaded without
> specifying the resources as module parameters.

Which powerpc-based machines have IPMI?

Paul.
