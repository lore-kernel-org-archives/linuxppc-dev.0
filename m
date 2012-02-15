Return-Path: <paulus@ozlabs.org>
Date: Wed, 15 Feb 2012 15:16:09 +1100
From: Paul Mackerras <paulus@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v6 00/10] fadump: Firmware-assisted dump support for
 Powerpc.
Message-ID: <20120215041608.GA15258@bloggs.ozlabs.ibm.com>
References: <20111210064301.10195.3344.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111210064301.10195.3344.stgit@mars.in.ibm.com>
Cc: Amerigo Wang <amwang@redhat.com>, Kexec-ml <kexec@lists.infradead.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Randy Dunlap <rdunlap@xenotime.net>,
 Anton Blanchard <anton@samba.org>, Vivek Goyal <vgoyal@redhat.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Dec 10, 2011 at 12:19:59PM +0530, Mahesh J Salgaonkar wrote:

> The most of the code implementation has been adapted from phyp assisted dump
> implementation written by Linas Vepstas and Manish Ahuja.

When you repost the series, please be explicit about what the
relationship between the new fadump facility and the old phyp-dump
is, both in the documentation you're adding and in the patch
descriptions.

I gather that fadump uses the same firmware interfaces as phyp-dump,
and can be characterised as a rewrite of phyp-dump.  It would be good
if you would explicitly mention:

- What advantages fadump has over phyp-dump
- Whether there are any capabilities that phyp-dump does that fadump
  doesn't
- What is different between fadump and phyp-dump in the interface to
  usermode code
- Any user-visible differences between how fadump operates compared to
  phyp-dump.  For example, will users see a difference in how much
  memory is available to the kernel?

Paul.
