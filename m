Return-Path: <paulus@ozlabs.org>
Date: Mon, 5 Aug 2013 14:34:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: powerpc: kvm: add signed type cast for comparation
Message-ID: <20130805043406.GD19254@iris.ozlabs.ibm.com>
References: <51ECD203.9050507@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51ECD203.9050507@asianux.com>
Cc: Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, agraf@suse.de,
 kvm-ppc@vger.kernel.org, pbonzini@redhat.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 22, 2013 at 02:32:35PM +0800, Chen Gang wrote:
> 'rmls' is 'unsigned long', lpcr_rmls() will return negative number when
> failure occurs, so it need a type cast for comparing.
> 
> 'lpid' is 'unsigned long', kvmppc_alloc_lpid() return negative number
> when failure occurs, so it need a type cast for comparing.
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Looks right, thanks.

Acked-by: Paul Mackerras <paulus@samba.org>
