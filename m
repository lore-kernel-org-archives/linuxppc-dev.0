Return-Path: <paulus@ozlabs.org>
Date: Tue, 17 May 2011 21:15:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/13] Hypervisor-mode KVM on POWER7
Message-ID: <20110517111536.GC7924@brick.ozlabs.ibm.com>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<764651B6-6DDA-49DC-AA95-52CD86FF82D9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <764651B6-6DDA-49DC-AA95-52CD86FF82D9@suse.de>
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 17, 2011 at 11:46:34AM +0200, Alexander Graf wrote:

> Very nice patches indeed :). Is there any way I can test them? I
> don't like pulling code that I couldn't run anywhere yet.

I can understand that, but unfortunately there are no machines
available outside of IBM at this stage that can run this stuff.

Do you think that the earlier patches in the series could go in for
2.6.40?  Patches 1 to 8 don't require hypervisor mode and can be
tested on a G5 or whatever.

What would be the path for these patches to get upstream?  Would this
stuff normally go through Avi's tree?  There is a bit of a
complication in that they are based on Ben's next branch.  Would Avi
pull Ben's next branch, or would they go in via Ben's tree?

Thanks,
Paul.
