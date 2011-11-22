Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Miche Baker-Harvey <miche@google.com>
Subject: Re: [PATCH v3 2/3] hvc_init(): Enforce one-time initialization.
In-Reply-To: <CAB8Rdaqno9kVHB8wsbH5=zs_ppUkd1G=siywFFfH3Ud21qK3FA@mail.gmail.com>
References: <20111108214452.28884.14840.stgit@miche.sea.corp.google.com>
 <20111108214504.28884.61814.stgit@miche.sea.corp.google.com>
 <874nybqo0o.fsf@rustcorp.com.au>
 <CAB8RdapbaueyWLJuJDE_ZdvLkRNM4sQHTxgmgO=jrnXZ6YPSmA@mail.gmail.com>
 <87lira9ii7.fsf@rustcorp.com.au>
 <CAB8Rdaqno9kVHB8wsbH5=zs_ppUkd1G=siywFFfH3Ud21qK3FA@mail.gmail.com>
Date: Tue, 22 Nov 2011 11:28:09 +1030
Message-ID: <877h2tx9b2.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, xen-devel@lists.xensource.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Anton Blanchard <anton@samba.org>,
 Amit Shah <amit.shah@redhat.com>, Mike Waychison <mikew@google.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Eric Northrup <digitaleric@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 21 Nov 2011 14:16:38 -0800, Miche Baker-Harvey <miche@google.com> wrote:
> Thanks, Rusty.  I'm not using QEMU though, just KVM.   I create the device, wait
> for the message from the guest that the device is ready, and then add ports.
> 
> Miche

OK, since Amit was the one who implemented multi-port console, I'm going
to hand this to him.

I'm sure he's been looking for excuses to dive back into the console
code!

Cheers,
Rusty.
