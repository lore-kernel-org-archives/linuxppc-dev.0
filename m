Date: Wed, 31 Mar 2004 10:30:21 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Eugene Surovegin <ebs@ebshome.net>,
	John Whitney <johnw@sands-edge.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Proposed changes to io.h
Message-ID: <20040331103021.C17284@home.com>
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com> <20040331164423.GA417@gate.ebshome.net> <406AF8B3.6010002@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <406AF8B3.6010002@embeddededge.com>; from dan@embeddededge.com on Wed, Mar 31, 2004 at 11:58:27AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 31, 2004 at 11:58:27AM -0500, Dan Malek wrote:
>
> Eugene Surovegin wrote:
>
> > I wonder will it work on 4xx CPUs which don't have floating point unit?
>
> It won't work on anything, will it?  Floating point isn't enabled for
> the kernel, unless I missed that update.

It will. The proposed changes turn on FP, save the scratch FP reg
context, and the restore everything (all under lock). Like was
mentioned, it's ugly but works. I know a few people doing this
(usually in custom MTD 64-bit access functions).

-Matt

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
