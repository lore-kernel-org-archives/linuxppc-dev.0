Return-Path: <paulus@ozlabs.org>
Date: Thu, 19 May 2011 15:22:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/13] Hypervisor-mode KVM on POWER7
Message-ID: <20110519052246.GA8165@drongo>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<764651B6-6DDA-49DC-AA95-52CD86FF82D9@suse.de>
	<20110517111536.GC7924@brick.ozlabs.ibm.com>
	<14CFAA70-1747-4902-8CC1-4BE924CAD031@suse.de>
	<4DD25F10.4030707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DD25F10.4030707@redhat.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Alexander Graf <agraf@suse.de>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 17, 2011 at 02:42:08PM +0300, Avi Kivity wrote:
> On 05/17/2011 02:38 PM, Alexander Graf wrote:
> >>
> >>  What would be the path for these patches to get upstream?  Would this
> >>  stuff normally go through Avi's tree?  There is a bit of a
> >>  complication in that they are based on Ben's next branch.  Would Avi
> >>  pull Ben's next branch, or would they go in via Ben's tree?
> >
> >Usually the ppc tree gets merged into Avi's tree and goes on from
> >there. When we have interdependencies, we can certainly do it
> >differently though. We can also shove them through Ben's tree this
> >time around, as there are more dependencies on ppc code than KVM
> >code.
> >
> 
> Yes, both options are fine.  If it goes through kvm.git I can merge
> Ben's tree (provided it is append-only) and apply the kvm-ppc
> patches on top.

OK, the easiest thing is for them to go via Ben's tree, I think, since
they depend so much on other stuff in Ben's tree.

Alex, could you give Ben an acked-by for patches 1-8 of the series?
There haven't been any changes requested for them.

Thanks,
Paul.
