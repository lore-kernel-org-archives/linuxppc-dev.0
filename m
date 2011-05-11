Return-Path: <paulus@ozlabs.org>
Date: Thu, 12 May 2011 07:17:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 13/13] kvm/powerpc: Allow book3s_hv guests to use SMT
	processor modes
Message-ID: <20110511211745.GO2837@brick.ozlabs.ibm.com>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104656.GN2837@brick.ozlabs.ibm.com>
	<20110511134415.GA1134@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110511134415.GA1134@lst.de>
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>,
	kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 11, 2011 at 03:44:15PM +0200, Christoph Hellwig wrote:
> On Wed, May 11, 2011 at 08:46:56PM +1000, Paul Mackerras wrote:
> > arch/powerpc/sysdev/xics/icp-native.c.
> 
> What kernel tree do I need to actually have that file?

The "next" branch of
git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git

Paul.
