Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 9CD1A2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 00:24:55 +1000 (EST)
Subject: Re: [PATCH] arch: powerpc: kvm: add signed type cast for comparation
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <51FF3D0B.6050609@asianux.com>
Date: Wed, 28 Aug 2013 16:24:44 +0200
Message-Id: <0FAEAF08-2C96-41BB-8E8F-B6E8F8F176C1@suse.de>
References: <51ECD203.9050507@asianux.com>
 <20130805043406.GD19254@iris.ozlabs.ibm.com> <51FF3D0B.6050609@asianux.com>
To: Chen Gang <gang.chen@asianux.com>
Cc: Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 pbonzini@redhat.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05.08.2013, at 07:50, Chen Gang wrote:

> On 08/05/2013 12:34 PM, Paul Mackerras wrote:
>> On Mon, Jul 22, 2013 at 02:32:35PM +0800, Chen Gang wrote:
>>>> 'rmls' is 'unsigned long', lpcr_rmls() will return negative number when
>>>> failure occurs, so it need a type cast for comparing.
>>>> 
>>>> 'lpid' is 'unsigned long', kvmppc_alloc_lpid() return negative number
>>>> when failure occurs, so it need a type cast for comparing.
>>>> 
>>>> 
>>>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> Looks right, thanks.
>> 
>> Acked-by: Paul Mackerras <paulus@samba.org>
>> 
>> 
> 
> Thank you very much.

Thanks, applied to kvm-ppc-queue.


Alex
