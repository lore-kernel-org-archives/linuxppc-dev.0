Message-ID: <3D541AE9.40007@dslextreme.com>
Date: Fri, 09 Aug 2002 12:41:29 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: First steps to OCP device model integration
References: <20020809042605.GC23642@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
> THe patch below implements the first steps in transitioning the
> handling of 4xx OCP devices to the unfied device model (in 2.5).  So
> far the code just registers an ocp bus and registers each device
> described in core_ocp on that bus.  The next step is to convert the
> actual device drivers so that that they register with the unified
> driver tree rather than through the old ocp_register() mechanism.
>
> I will commit this shortly unless there are serious objections.
>

I object seriously.

  Some of what you have might be useful.:) OCP is not just for 4xx.  In
fact the name may need to change.  I have been working on overhalling
this interface and testing the ideas before having a review of the
changes.  I am on the hook to Paul and others to get this out in the
open to discuss and am not ready.  So if you could just relax and wait I
would appriciate it.  I would rather see the 2.5 kernel boot on a few
4xx boards

Armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
