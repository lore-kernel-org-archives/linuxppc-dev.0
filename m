Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id D2C752C011C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 21:41:37 +1000 (EST)
Message-ID: <524AB4FC.10705@redhat.com>
Date: Tue, 01 Oct 2013 13:41:48 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 00/11 Allow PR and HV KVM to coexist in one kernel
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <878uyibkq2.fsf@linux.vnet.ibm.com>
 <48337EF0-471D-4BDB-8088-FC072FF82753@suse.de>
 <87had2bgme.fsf@linux.vnet.ibm.com> <524990A9.60704@suse.de>
 <87ob79cjvm.fsf@linux.vnet.ibm.com> <524AB3AE.5000503@suse.de>
In-Reply-To: <524AB3AE.5000503@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Gleb Natapov <gleb@redhat.com>,
 "<kvm@vger.kernel.org> list" <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 =?ISO-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Il 01/10/2013 13:36, Alexander Graf ha scritto:
>>>>
>>> Yes, so we should verify in the machine models that we're runnable with
>>> the currently selected type at least, to give the user a sensible error
>>> message.
>> Something like the below
> 
> I like that one a lot. Andreas, Paolo, what do you think?

Yes, it's fine.

Paolo
