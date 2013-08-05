Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 450462C0082
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Aug 2013 15:51:12 +1000 (EST)
Message-ID: <51FF3D0B.6050609@asianux.com>
Date: Mon, 05 Aug 2013 13:50:03 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] arch: powerpc: kvm: add signed type cast for comparation
References: <51ECD203.9050507@asianux.com>
 <20130805043406.GD19254@iris.ozlabs.ibm.com>
In-Reply-To: <20130805043406.GD19254@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
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

On 08/05/2013 12:34 PM, Paul Mackerras wrote:
> On Mon, Jul 22, 2013 at 02:32:35PM +0800, Chen Gang wrote:
>> > 'rmls' is 'unsigned long', lpcr_rmls() will return negative number when
>> > failure occurs, so it need a type cast for comparing.
>> > 
>> > 'lpid' is 'unsigned long', kvmppc_alloc_lpid() return negative number
>> > when failure occurs, so it need a type cast for comparing.
>> > 
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Looks right, thanks.
> 
> Acked-by: Paul Mackerras <paulus@samba.org>
> 
> 

Thank you very much.

-- 
Chen Gang
