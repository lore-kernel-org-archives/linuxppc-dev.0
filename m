Return-Path: <alan@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id 70905B6F69
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 11:50:05 +1100 (EST)
Date: Fri, 2 Dec 2011 00:51:50 +0000
From: Alan Cox <alan@linux.intel.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 1/3] serial: make bugs field not specific to 8250 type
 uarts.
Message-ID: <20111202005150.2e9fde43@bob.linux.org.uk>
In-Reply-To: <1322783258-20443-2-git-send-email-paul.gortmaker@windriver.com>
References: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>
 <1322783258-20443-2-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Make the bugs field part of the globally visible struct
> uart_port and remove the 8250 specific one.

Except all the bits in it are 8250 specific things or names that are
meaningless in generic form - no. I also don't want to encourage flags
and bug bits. We already have too many and its making the code a mess.
So right now we want less not more.
