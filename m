Message-ID: <3E650914.7040007@embeddededge.com>
Date: Tue, 04 Mar 2003 15:14:12 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Trivial patch to add PVR_7455
References: <20030304190421.GA4490@rover.farnsworth.org> <20030304195101.GA4635@rover.farnsworth.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dale Farnsworth wrote:

> I'm told that using PVR_XXXX is deprecated and that in my case
> I'd be better off using CPU_FTR_L3CR.

It depends what you are trying to discover about the processor.
I believe there are at least three different silicon revisions of
7455 processors defined in the cpu features table.  One purpose
of cpu features is to provide a standard set of information so
you don't have to test PVR all of the time, but rather just check
if the cpu has the feature of interest.

have fun :-)


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
