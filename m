Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id EF2312C0040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2013 18:29:03 +1000 (EST)
Message-ID: <521B11C2.3040801@redhat.com>
Date: Mon, 26 Aug 2013 10:28:50 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH 2/2] ppc: kvm: use anon_inode_getfd() with O_CLOEXEC flag
References: <cover.1377372576.git.ydroneaud@opteya.com>
 <b7ae23be3a3d4a2f57eca6cfc7f9361da883ceca.1377372576.git.ydroneaud@opteya.com>
 <3557EF65-4327-4DAE-999A-B0EE13C433F5@suse.de> <521B0622.9090208@redhat.com>
 <156342996ba92cb5f49519b0c2e9d6ac@meuh.org>
In-Reply-To: <156342996ba92cb5f49519b0c2e9d6ac@meuh.org>
Content-Type: text/plain; charset=UTF-8
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
 Paolo Bonzini <paolo.bonzini@gmail.com>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Il 26/08/2013 10:23, Yann Droneaud ha scritto:
> 
> Sounds a lot like InfiniBand subsystem behavor: IB file descriptors
> are of no use accross exec() since memory mappings tied to those fds
> won't be available in the new process:
> 
> https://lkml.org/lkml/2013/7/8/380
> http://mid.gmane.org/f58540dc64fec1ac0e496dfcd3cc1af7@meuh.org

Yes, it is very similar.

Paolo
