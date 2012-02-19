Return-Path: <paulus@ozlabs.org>
Date: Mon, 20 Feb 2012 10:47:51 +1100
From: Paul Mackerras <paulus@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v7 00/10] fadump: Firmware-assisted dump support for
 Powerpc.
Message-ID: <20120219234751.GA10186@bloggs.ozlabs.ibm.com>
References: <20120216111050.4733.38034.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120216111050.4733.38034.stgit@mars>
Cc: Anton Blanchard <anton@samba.org>, Amerigo Wang <amwang@redhat.com>,
 Kexec-ml <kexec@lists.infradead.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Randy Dunlap <rdunlap@xenotime.net>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 16, 2012 at 04:44:06PM +0530, Mahesh J Salgaonkar wrote:

> Please find the version 7 of the patchset that implements firmware-assisted
> dump mechanism to capture kernel crash dump for Powerpc architecture.
> Firmware-assisted dump is a robust mechanism to get reliable kernel crash
> dump with the assistance of firmware. This approach does not use kexec,
> instead firmware assists in booting the kdump kernel while preserving memory
> contents.

For the series:

Reviewed-by: Paul Mackerras <paulus@samba.org>

I think it's pretty much good enough to go in now.  I have one relatively
minor comment about a printk which could be addressed if you decide to
do another version of the series.

Paul.
