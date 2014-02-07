Return-Path: <mpe@ellerman.id.au>
Message-ID: <1391757933.23461.8.camel@concordia>
Subject: Re: [PATCH 2/2] power8, perf: Export raw event codes through sysfs
 interface
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 07 Feb 2014 18:25:33 +1100
In-Reply-To: <1381902780-2719-3-git-send-email-khandual@linux.vnet.ibm.com>
References: <1381902780-2719-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1381902780-2719-3-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-10-16 at 11:23 +0530, Anshuman Khandual wrote:
> This patch exports a set of POWER8 PMU raw event codes through
> sysfs interface. Right now the raw event set matches the entire
> set of POWER8 events found in libpfm4 library.

As for the POWER7 events, these all need to be in the ABI file too.

Please update & resend.

cheers
