Return-Path: <paulus@ozlabs.org>
Date: Tue, 17 Jan 2012 16:02:19 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v3] KVM: Move gfn_to_memslot() to kvm_host.h
Message-ID: <20120117050219.GA9170@drongo>
References: <20111220092102.GA5626@bloggs.ozlabs.ibm.com>
 <20120112104115.GA32021@bloggs.ozlabs.ibm.com>
 <20120113060951.GB15875@drongo>
 <E1127F8D-E42E-44C7-B869-2B46C2812C8F@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1127F8D-E42E-44C7-B869-2B46C2812C8F@suse.de>
Cc: linuxppc-dev@ozlabs.org, Avi Kivity <avi@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 16, 2012 at 02:30:41PM +0100, Alexander Graf wrote:

> Which tree is this against? I got this diff between your patch and the patch when applied on my tree:

It's against your tree (previously) plus my first 13-patch series, but
not the second series of 5 patches, which presumably why you got the
difference.  Sounds like you got it applied OK; if not let me know and
I'll rebase against your current tree.

Paul.
