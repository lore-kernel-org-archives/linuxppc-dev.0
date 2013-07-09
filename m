Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/2] powerpc: allow kvm to use kerel debug framework
In-reply-to: <C4D71A1A-3D5B-4C9C-A26B-9EAFFD9D87C5@suse.de>
References: <1372918546-15075-1-git-send-email-Bharat.Bhushan@freescale.com>
 <C4D71A1A-3D5B-4C9C-A26B-9EAFFD9D87C5@suse.de>
Date: Tue, 09 Jul 2013 14:24:32 +1000
Message-ID: <14504.1373343872@ale.ozlabs.ibm.com>
Cc: linux-kernel@vger.kernel.org, Bharat Bhushan <bharat.bhushan@freescale.com>,
 Bharat Bhushan <r65777@freescale.com>, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> wrote:

> 
> On 04.07.2013, at 08:15, Bharat Bhushan wrote:
> 
> > From: Bharat Bhushan <bharat.bhushan@freescale.com>
> > 
> > This patchset moves the debug registers in a structure, which allows
> > kvm to use same structure for debug emulation.
> > 
> > Note: Earilier a patchset "https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-June/108132.html"
> > was sent which is a bunch of six patches. That patchset is divided into two parts:
> > 	1) powerpc specific changes (These 2 patches are actually have those changes)
> > 	2) KVM specific changes (will send separate patch on agraf repository)
> 
> Mikey, if you like those could you please apply the into a topic
> branch and get that one merged with Ben? I'd also pull it into my tree
> then.

benh would pull these directly.  

I'll have a chat with him to see if he wants my ACK before he does that.

Mikey
